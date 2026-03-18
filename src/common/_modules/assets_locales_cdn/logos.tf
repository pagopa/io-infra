resource "azurerm_cdn_frontdoor_endpoint" "logos_endpoint" {
  name                     = "io-p-itn-assets-fde-02"
  cdn_frontdoor_profile_id = module.azure_cdn.id

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_custom_domain" "logos_custom_domain" {
  name                     = "io-p-itn-assets-logos-domain"
  cdn_frontdoor_profile_id = module.azure_cdn.id
  dns_zone_id              = var.public_dns_zones.io.name
  host_name                = "assets.logos.io.pagopa.it"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_origin_group" "logos_origin_group" {
  name                     = "io-p-itn-assets-fdog-02"
  cdn_frontdoor_profile_id = module.azure_cdn.id

  health_probe {
    interval_in_seconds = 100
    protocol            = "Https"
  }

  load_balancing {}
}

resource "azurerm_cdn_frontdoor_origin" "logos_origin" {
  name                           = "iopstcdnassets"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.logos_origin_group.id
  enabled                        = true
  host_name                      = "iopstcdnassets.blob.core.windows.net"
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = "iopstcdnassets.blob.core.windows.net"
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = false
}

resource "azurerm_cdn_frontdoor_rule_set" "logos_ruleset" {
  name                     = "logosruleset"
  cdn_frontdoor_profile_id = module.azure_cdn.id
}

resource "azurerm_cdn_frontdoor_route" "logos_route" {
  name                            = "io-p-itn-assets-cdnr-02"
  cdn_frontdoor_endpoint_id       = azurerm_cdn_frontdoor_endpoint.logos_endpoint.id
  cdn_frontdoor_origin_group_id   = azurerm_cdn_frontdoor_origin_group.logos_origin_group.id
  cdn_frontdoor_origin_ids        = [azurerm_cdn_frontdoor_origin.logos_origin.id]
  cdn_frontdoor_rule_set_ids      = [azurerm_cdn_frontdoor_rule_set.logos_ruleset.id]
  cdn_frontdoor_custom_domain_ids = []
  enabled                         = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  link_to_default_domain = true

  cache {
    query_string_caching_behavior = "IgnoreQueryString"
  }
}

resource "azurerm_cdn_frontdoor_rule" "logos_global_cache" {
  name                      = "globalCache"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.logos_ruleset.id
  order                     = 1

  actions {
    route_configuration_override_action {
      cache_behavior                = "OverrideAlways"
      cache_duration                = "08:00:00" # 8 hours
      query_string_caching_behavior = "IgnoreQueryString"
    }
  }
}
