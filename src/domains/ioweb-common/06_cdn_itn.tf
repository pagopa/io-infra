data "azurerm_dns_zone" "ioapp_it" {
  name                = "ioapp.it"
  resource_group_name = data.azurerm_resource_group.core_ext.name
}

resource "azurerm_resource_group" "io_web_profile_itn_fe_rg" {
  name     = format("%s-fe-rg-01", local.project_itn)
  location = local.itn_location
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
    index_document     = "index.html"
    error_404_document = "it/404/index.html"
  }

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_profile" "portal_profile" {
  name                = format("%s-profile-portal-afd-01", local.project_itn)
  resource_group_name = azurerm_resource_group.io_web_profile_itn_fe_rg.name
  sku_name            = "Standard_AzureFrontDoor"

  tags = var.tags
}

data "azurerm_key_vault_certificate" "portal_custom_certificate" {
  name         = "account-ioapp-it"
  key_vault_id = module.key_vault.id
}

resource "azurerm_cdn_frontdoor_secret" "portal_certificate" {
  name                     = "certificate"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portal_profile.id

  secret {
    customer_certificate {
      key_vault_certificate_id = data.azurerm_key_vault_certificate.portal_custom_certificate.id
    }
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "portal_custom_domain" {
  name                     = format("%s-profile-fdd-01", local.project_itn)
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portal_profile.id

  dns_zone_id = data.azurerm_dns_zone.ioapp_it.id
  host_name   = "account.ioapp.it"

  tls {
    # Certificate managed by us and put in a kv
    certificate_type        = "CustomerCertificate"
    minimum_tls_version     = "TLS12"
    cdn_frontdoor_secret_id = azurerm_cdn_frontdoor_secret.portal_certificate.id
  }
}

resource "azurerm_cdn_endpoint" "portal_cdn_endpoint" {
  name                = format("%s-profile-fde-01", local.project_itn)
  profile_name        = azurerm_cdn_frontdoor_profile.portal_profile.name
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.io_web_profile_itn_fe_rg.name

  querystring_caching_behaviour = "BypassCaching"

  origin {
    name      = "primary"
    host_name = module.io_web_profile_itn_fe_st.primary_web_host
  }
}

resource "azurerm_cdn_frontdoor_rule_set" "portal_cdn_rule_set" {
  name                     = "Ruleset"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.portal_profile.id
}

resource "azurerm_cdn_frontdoor_rule" "portal_cdn_rule_global" {
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

resource "azurerm_cdn_frontdoor_rule" "portal_cdn_rule_force_https" {
  name                      = "EnforceHTTPS"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.portal_cdn_rule_set.id

  # NOTE: A Front Door Rule with a lesser order value will be applied before a rule with a greater order value.
  # If the Front Door Rule has an order value of 0 they do not require any conditions and the actions will always be applied.
  order = 1

  # IF
  conditions {
    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }
  }
  # THEN
  actions {
    url_redirect_action {
      # 302 Found
      redirect_type     = "Found"
      redirect_protocol = "Https"
      # Leave blank to preserve the incoming host.
      destination_hostname = ""
      destination_path     = ""
    }
  }
}

# This rule ensures that root files are always taken from the blob storage, therefore
# surpassing the caching internal capabilities of the CDN profile.
# This rule function is based from BypassCaching behaviour mode of the CDN
# profile
resource "azurerm_cdn_frontdoor_rule" "portal_cdn_rule_rootfiles" {
  name                      = "TakeRootFilesFromStorage"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.portal_cdn_rule_set.id

  # NOTE: A Front Door Rule with a lesser order value will be applied before a rule with a greater order value.
  # If the Front Door Rule has an order value of 0 they do not require any conditions and the actions will always be applied.
  order = 2

  # IF
  conditions {
    request_uri_condition {
      operator         = "Contains"
      negate_condition = true
      match_values     = ["?"]
    }
    request_uri_condition {
      operator     = "EndsWith"
      match_values = ["/"]
    }

  }
  # THEN
  actions {
    url_redirect_action {
      # 302 Found
      redirect_type     = "Found"
      redirect_protocol = "Https"
      # Leave blank to preserve the incoming host.
      destination_hostname = ""
      destination_path     = ""
      query_string         = "refresh=true"
    }
  }
}
