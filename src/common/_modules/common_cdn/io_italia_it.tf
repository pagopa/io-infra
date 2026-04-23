resource "azurerm_cdn_frontdoor_custom_domain" "io_italia_it" {
  name                     = "${var.prefix}-${var.env_short}-cdn-common-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  dns_zone_id              = var.public_dns_zones.io_italia_it.id
  host_name                = "io.italia.it"

  tls {
    certificate_type        = "CustomerCertificate"
    cdn_frontdoor_secret_id = azurerm_cdn_frontdoor_secret.io_italia_it.id
  }
}

resource "azurerm_cdn_frontdoor_secret" "io_italia_it" {
  name                     = "${var.prefix}-${var.env_short}-cdn-common-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id

  secret {
    customer_certificate {
      key_vault_certificate_id = "TODO"
    }
  }
}

resource "azurerm_dns_txt_record" "io_italia_it" {
  name                = join(".", ["_dnsauth", azurerm_cdn_frontdoor_custom_domain.io_italia_it.host_name])
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600

  record {
    value = azurerm_cdn_frontdoor_custom_domain.common_cdn.validation_token
  }
}

resource "azurerm_dns_a_record" "io_italia_it" {
  name                = "@"
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600
  target_resource_id  = azurerm_cdn_frontdoor_custom_domain.io_italia_it.id
}

resource "azurerm_cdn_frontdoor_endpoint" "io_italia_it" {
  name                     = "${var.prefix}-${var.env_short}-cdn-common-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
}

resource "azurerm_cdn_frontdoor_origin_group" "io_italia_it" {
  name                     = "io-p-cdnendpoint-iowebsite-Default"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  session_affinity_enabled = true

  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = 10

  health_probe {
    interval_in_seconds = 240
    path                = "/probes/healthcheck.txt"
    protocol            = "Https"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 16
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin" "io_italia_it" {
  name                          = "iopstcdniowebsite"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.io_italia_it.id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name = "iopstcdniowebsite.z6.web.core.windows.net"
  priority  = 1
  weight    = 1
}

resource "azurerm_cdn_frontdoor_route" "io_italia_it" {
  name                          = "iopcdnendpointiowebsite"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.io_italia_it.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.io_italia_it.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.io_italia_it.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.io_italia_it.id]
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.io_italia_it.id]
  link_to_default_domain          = false
}

resource "azurerm_cdn_frontdoor_rule_set" "io_italia_it" {
  name                     = "Migratediopcdnendpointiowebsite"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
}

# TODO - Rules