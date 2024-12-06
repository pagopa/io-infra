data "azurerm_dns_zone" "ioapp_it" {
  name                = "ioapp.it"
  resource_group_name = data.azurerm_resource_group.core_ext.name
}

data "azurerm_dns_zone" "account_ioapp_it" {
  name                = "account.ioapp.it"
  resource_group_name = data.azurerm_resource_group.core_ext.name
}

resource "azurerm_resource_group" "io_web_profile_itn_fe_rg" {
  name     = format("%s-fe-rg-01", local.project_itn)
  location = local.itn_location

  tags = var.tags
}

module "io_web_profile_itn_fe_st" {
  source = "github.com/pagopa/dx//infra/modules/azure_storage_account?ref=main"

  // s tier -> Standard LRS
  // l tier -> Standard ZRS
  tier = "l"

  # NOTE: domain omitted for characters shortage
  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = local.itn_location
    app_name        = replace("ioweb-profile", "-", "")
    instance_number = "01"
  }
  access_tier = "Hot"

  resource_group_name                  = azurerm_resource_group.io_web_profile_itn_fe_rg.name
  subnet_pep_id                        = data.azurerm_subnet.private_endpoints_subnet_itn.id
  private_dns_zone_resource_group_name = data.azurerm_resource_group.common_rg_weu.name

  # storage should be accessible by CDN via private endpoint
  # see https://learn.microsoft.com/en-us/azure/frontdoor/standard-premium/how-to-enable-private-link-storage-account
  force_public_network_access_enabled = false
  subservices_enabled = {
    blob = true
  }
  blob_features = {
    versioning = true
    change_feed = {
      enabled = false
    }
    immutability_policy = {
      enabled = false
    }
  }

  static_website = {
    enabled            = true
    index_document     = "index.html"
    error_404_document = "it/404/index.html"
  }

  tags = var.tags
}

#####################
# CDN
#####################
resource "azurerm_cdn_frontdoor_profile" "portal_profile" {
  name                = format("%s-%s-profile-portal-afd-01", local.product, var.domain)
  resource_group_name = azurerm_resource_group.io_web_profile_itn_fe_rg.name
  sku_name            = "Standard_AzureFrontDoor"

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "portal_cdn_endpoint" {
  name                     = format("%s-profile-fde-01", local.project_itn)
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portal_profile.id

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_origin_group" "portal_cdn_origin_group" {
  name                     = format("%s-profile-fdog-01", local.project_itn)
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portal_profile.id

  load_balancing {
    # latency in milliseconds for probes to fall into the lowest latency bucket.
    # defaults to 50
    additional_latency_in_milliseconds = 5
  }
}

resource "azurerm_cdn_frontdoor_origin" "portal_cdn_origin" {
  name                           = format("%s-profile-fdo-01", local.project_itn)
  enabled                        = true
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.portal_cdn_origin_group.id
  host_name                      = module.io_web_profile_itn_fe_st.primary_web_host
  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_rule_set" "portal_cdn_rule_set" {
  name                     = "Ruleset"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portal_profile.id
}

resource "azurerm_cdn_frontdoor_rule" "portal_cdn_rule_global" {
  depends_on = [azurerm_cdn_frontdoor_origin_group.portal_cdn_origin_group, azurerm_cdn_frontdoor_origin.portal_cdn_origin]

  name                      = "Global"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.portal_cdn_rule_set.id

  # NOTE: A Front Door Rule with a lesser order value will be applied before a rule with a greater order value.
  # If the Front Door Rule has an order value of 0 they do not require any conditions and the actions will always be applied.
  order = 0

  actions {
    response_header_action {
      header_name   = "Strict-Transport-Security"
      header_action = "Overwrite"
      value         = "max-age=31536000" # 1 year
    }
    response_header_action {
      header_name   = "Content-Security-Policy"
      header_action = "Append"
      value         = "script-src 'self' 'unsafe-inline'; worker-src 'none'; font-src data: 'self'; object-src 'none';"
    }
    response_header_action {
      header_name   = "Cache-Control"
      header_action = "Overwrite"
      value         = "no-cache"
    }
  }
}

# This rule ensures that root files are always taken from the blob storage, therefore
# surpassing the caching internal capabilities of the CDN profile.
resource "azurerm_cdn_frontdoor_rule" "portal_cdn_rule_rootfiles" {
  depends_on                = [azurerm_cdn_frontdoor_origin_group.portal_cdn_origin_group, azurerm_cdn_frontdoor_origin.portal_cdn_origin]
  name                      = "TakeRootFilesFromStorage"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.portal_cdn_rule_set.id

  # NOTE: A Front Door Rule with a lesser order value will be applied before a rule with a greater order value.
  # If the Front Door Rule has an order value of 0 they do not require any conditions and the actions will always be applied.
  order = 1

  # IF
  conditions {
    request_uri_condition {
      operator     = "EndsWith"
      match_values = ["/"]
    }

  }
  # THEN
  actions {
    route_configuration_override_action {
      cache_behavior = "Disabled"
    }
  }
}

resource "azurerm_cdn_frontdoor_route" "portal_cdn_route" {
  depends_on = [
    azurerm_cdn_frontdoor_origin_group.portal_cdn_origin_group,
    azurerm_cdn_frontdoor_origin.portal_cdn_origin,
    azurerm_cdn_frontdoor_endpoint.portal_cdn_endpoint,
    azurerm_cdn_frontdoor_rule_set.portal_cdn_rule_set
  ]

  name    = format("%s-profile-fdr-01", local.project_itn)
  enabled = true

  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.portal_cdn_origin_group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.portal_cdn_origin.id]
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.portal_cdn_endpoint.id
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.portal_cdn_rule_set.id]

  supported_protocols    = ["Http", "Https"]
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]

  cache {
    query_string_caching_behavior = "IgnoreQueryString"
    compression_enabled           = false
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "portal_custom_domain" {
  name                     = format("%s-profile-fdd-01", local.project_itn)
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portal_profile.id

  dns_zone_id = data.azurerm_dns_zone.account_ioapp_it.id
  host_name   = "account.ioapp.it"

  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "portal_cdn_domain_association" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.portal_custom_domain.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.portal_cdn_route.id]
}
#####################
