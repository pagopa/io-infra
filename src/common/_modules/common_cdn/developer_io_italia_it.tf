resource "azurerm_cdn_frontdoor_custom_domain" "developer_io_italia_it" {
  name                     = "developer-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  dns_zone_id              = var.public_dns_zones.io_italia_it.id
  host_name                = "developer.io.italia.it"

  tls {
    certificate_type        = "CustomerCertificate"
    cdn_frontdoor_secret_id = azurerm_cdn_frontdoor_secret.developer_io_italia_it.id
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "developer_io_italia_it_legacy" {
  name                     = "io-p-cdnendpoint-developerportal-Migrated"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  dns_zone_id              = var.public_dns_zones.io_italia_it.id
  host_name                = "io-p-cdnendpoint-developerportal.azureedge.net"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_secret" "developer_io_italia_it" {
  name                     = "MigratedSecret-developer-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id

  secret {
    customer_certificate {
      key_vault_certificate_id = "https://io-p-kv-common.vault.azure.net/certificates/developer-io-italia-it"
    }
  }
}

# TODO: uncomment snippet when switching to managed certificates

/*
resource "azurerm_dns_txt_record" "developer_io_italia_it" {
  name                = join(".", ["_dnsauth", "developer"])
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600

  record {
    value = azurerm_cdn_frontdoor_custom_domain.developer_io_italia_it.validation_token
  }
}
*/

resource "azurerm_dns_cname_record" "developer_io_italia_it" {
  name                = "developer"
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 300
  record              = "io-p-cdnendpoint-developerportal.azureedge.net"
  # TODO: switch to resource alias
  # target_resource_id  = azurerm_cdn_frontdoor_endpoint.developer_io_italia_it.id
}

resource "azurerm_cdn_frontdoor_endpoint" "developer_io_italia_it" {
  name                     = "io-p-cdnendpoint-developerportal"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  tags                     = var.tags
}

resource "azurerm_cdn_frontdoor_origin_group" "developer_io_italia_it" {
  name                     = "io-p-cdnendpoint-developerportal-Default"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  session_affinity_enabled = false

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10

  health_probe {
    interval_in_seconds = 240
    path                = "/probes/healthcheck.txt"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 4
    successful_samples_required        = 2
  }
}

resource "azurerm_cdn_frontdoor_origin" "developer_io_italia_it" {
  name                          = "primary"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.developer_io_italia_it.id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name          = "iopstcdndeveloperportal.z6.web.core.windows.net"
  origin_host_header = "iopstcdndeveloperportal.z6.web.core.windows.net"
  priority           = 1
  weight             = 1000
}

resource "azurerm_cdn_frontdoor_route" "developer_io_italia_it" {
  name                          = "iopcdnendpointdeveloperportal"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.developer_io_italia_it.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.developer_io_italia_it.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.developer_io_italia_it.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.developer_io_italia_it.id]
  enabled                       = true

  forwarding_protocol    = "MatchRequest"
  https_redirect_enabled = false
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Https"]

  cdn_frontdoor_custom_domain_ids = [
    azurerm_cdn_frontdoor_custom_domain.developer_io_italia_it.id,
    azurerm_cdn_frontdoor_custom_domain.developer_io_italia_it_legacy.id
  ]
  link_to_default_domain = true

  cache {
    compression_enabled           = false
    query_string_caching_behavior = "IgnoreQueryString"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "developer_io_italia_it" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.developer_io_italia_it.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.developer_io_italia_it.id]
}

# Ruleset and rules #

resource "azurerm_cdn_frontdoor_rule_set" "developer_io_italia_it" {
  name                     = "Migratediopcdnendpointdeveloperportal"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
}

resource "azurerm_cdn_frontdoor_rule" "developer_io_italia_it_enforce_https" {
  name                      = "EnforceHTTPS"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.developer_io_italia_it.id
  order                     = 1

  conditions {
    request_scheme_condition {
      operator         = "Equal"
      match_values     = ["HTTPS"]
      negate_condition = true
    }
  }

  actions {
    url_redirect_action {
      redirect_type        = "Found"
      redirect_protocol    = "Https"
      destination_hostname = ""
    }
  }
}