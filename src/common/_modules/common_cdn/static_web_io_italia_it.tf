resource "azurerm_cdn_frontdoor_custom_domain" "static_web_io_italia_it" {
  name                     = "static-web-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  dns_zone_id              = var.public_dns_zones.io_italia_it.id
  host_name                = "static-web.io.italia.it"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "static_web_io_italia_it_legacy" {
  name                     = "io-p-cdnendpoint-websiteassets-Migrated"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  dns_zone_id              = var.public_dns_zones.io_italia_it.id
  host_name                = "io-p-cdnendpoint-websiteassets.azureedge.net"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_dns_txt_record" "static_web_io_italia_it" {
  name                = join(".", ["_dnsauth", "static-web"])
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600

  record {
    value = azurerm_cdn_frontdoor_custom_domain.static_web_io_italia_it.validation_token
  }
}

resource "azurerm_dns_cname_record" "static_web_io_italia_it" {
  name                = "static-web"
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600
  target_resource_id  = azurerm_cdn_frontdoor_endpoint.static_web_io_italia_it.id
}

resource "azurerm_cdn_frontdoor_endpoint" "static_web_io_italia_it" {
  name                     = "io-p-cdnendpoint-websiteassets"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  tags                     = var.tags
}

resource "azurerm_cdn_frontdoor_origin_group" "static_web_io_italia_it" {
  name                     = "io-p-cdnendpoint-websiteassets-Default"
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

resource "azurerm_cdn_frontdoor_origin" "static_web_io_italia_it" {
  name                          = "primary"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.static_web_io_italia_it.id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name          = "iopstcdnwebsiteassets.z6.web.core.windows.net"
  origin_host_header = "iopstcdnwebsiteassets.z6.web.core.windows.net"
  priority           = 1
  weight             = 1000
}

resource "azurerm_cdn_frontdoor_route" "static_web_io_italia_it" {
  name                          = "iopcdnendpointwebsiteassets"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.static_web_io_italia_it.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.static_web_io_italia_it.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.static_web_io_italia_it.id]
  enabled                       = true

  forwarding_protocol    = "MatchRequest"
  https_redirect_enabled = false
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Https"]

  cdn_frontdoor_custom_domain_ids = [
    azurerm_cdn_frontdoor_custom_domain.static_web_io_italia_it.id,
    azurerm_cdn_frontdoor_custom_domain.static_web_io_italia_it_legacy.id
  ]
  link_to_default_domain = true

  cache {
    compression_enabled           = false
    query_string_caching_behavior = "IgnoreQueryString"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "static_web_io_italia_it" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.static_web_io_italia_it.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.static_web_io_italia_it.id]
}
