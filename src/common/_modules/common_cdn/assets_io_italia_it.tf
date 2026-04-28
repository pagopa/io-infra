resource "azurerm_cdn_frontdoor_custom_domain" "assets_io_italia_it" {
  name                     = "assets-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  dns_zone_id              = var.public_dns_zones.io_italia_it.id
  host_name                = "assets.io.italia.it"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_dns_txt_record" "assets_io_italia_it" {
  name                = join(".", ["_dnsauth", "assets"])
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600

  record {
    value = azurerm_cdn_frontdoor_custom_domain.assets_io_italia_it.validation_token
  }
}

resource "azurerm_dns_cname_record" "assets_io_italia_it" {
  name                = "assets"
  zone_name           = var.public_dns_zones.io_italia_it.name
  resource_group_name = var.resource_group_external
  ttl                 = 3600
  target_resource_id  = azurerm_cdn_frontdoor_endpoint.assets_io_italia_it.id
}

resource "azurerm_cdn_frontdoor_endpoint" "assets_io_italia_it" {
  name                     = "io-p-cdnendpoint-assets"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
  tags                     = var.tags
}

resource "azurerm_cdn_frontdoor_origin_group" "assets_io_italia_it" {
  name                     = "io-p-cdnendpoint-assets-Default"
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

resource "azurerm_cdn_frontdoor_origin" "assets_io_italia_it" {
  name                          = "primary"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.assets_io_italia_it.id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name          = "iopstcdnassets.z6.web.core.windows.net"
  origin_host_header = "iopstcdnassets.z6.web.core.windows.net"
  priority           = 1
  weight             = 1000
}

resource "azurerm_cdn_frontdoor_route" "assets_io_italia_it" {
  name                          = "iopcdnendpointassets"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.assets_io_italia_it.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.assets_io_italia_it.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.assets_io_italia_it.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.assets_io_italia_it.id]
  enabled                       = true

  forwarding_protocol    = "MatchRequest"
  https_redirect_enabled = false
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.assets_io_italia_it.id]
  link_to_default_domain          = true

  cache {
    compression_enabled           = false
    query_string_caching_behavior = "IgnoreQueryString"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "assets_io_italia_it" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.assets_io_italia_it.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.assets_io_italia_it.id]
}

# Ruleset and rules #

resource "azurerm_cdn_frontdoor_rule_set" "assets_io_italia_it" {
  name                     = "Migratediopcdnendpointassets"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.common_cdn.id
}

resource "azurerm_cdn_frontdoor_rule" "assets_io_italia_it_global_cache" {
  name                      = "Global"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.assets_io_italia_it.id
  order                     = 0
  actions {
    route_configuration_override_action {
      query_string_caching_behavior = "IgnoreQueryString"
      cache_behavior                = "OverrideAlways"
      cache_duration                = "08:00:00"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "assets_io_italia_it_services_data_cache" {
  name                      = "servicesdatacache"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.assets_io_italia_it.id
  order                     = 1

  conditions {
    url_path_condition {
      operator     = "BeginsWith"
      match_values = ["/services-data"]
    }
  }

  actions {
    route_configuration_override_action {
      query_string_caching_behavior = "IgnoreQueryString"
      cache_behavior                = "OverrideAlways"
      cache_duration                = "00:15:00"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "assets_io_italia_it_bonus_cache" {
  name                      = "bonuscache"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.assets_io_italia_it.id
  order                     = 2

  conditions {
    url_path_condition {
      operator     = "BeginsWith"
      match_values = ["/bonus"]
    }
  }

  actions {
    route_configuration_override_action {
      query_string_caching_behavior = "IgnoreQueryString"
      cache_behavior                = "OverrideAlways"
      cache_duration                = "00:15:00"
    }
  }
}

resource "azurerm_cdn_frontdoor_rule" "assets_io_italia_it_status_cache" {
  name                      = "statuscache"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.assets_io_italia_it.id
  order                     = 3

  conditions {
    url_path_condition {
      operator     = "BeginsWith"
      match_values = ["/status"]
    }
  }

  actions {
    route_configuration_override_action {
      query_string_caching_behavior = "IgnoreQueryString"
      cache_behavior                = "OverrideAlways"
      cache_duration                = "00:05:00"
    }
  }
}
