resource "azurerm_cdn_frontdoor_profile" "assets_locales_frontdoor_profile" {
  name                = format("%s-assets-afd-01", var.project)
  resource_group_name = var.resource_group_cdn
  sku_name            = "Standard_AzureFrontDoor"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_origin" "assets_locales_origin" {
  name                           = format("%s-assets-storage-account-fdo-01", var.project)
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.assets_locales_origin_group.id
  enabled                        = true
  host_name                      = "iopitnassetsst01.z38.web.core.windows.net"
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = "iopitnassetsst01.z38.web.core.windows.net"
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_origin_group" "assets_locales_origin_group" {
  name                     = format("%s-assets-fdog-01", var.project)
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.assets_locales_frontdoor_profile.id

  health_probe {
    interval_in_seconds = 100
    protocol            = "Https"
    path                = "/probes/healthcheck.txt"
    request_type        = "HEAD"
  }

  load_balancing {}
}

resource "azurerm_cdn_frontdoor_endpoint" "assets_locales_endpoint" {
  name                     = format("%s-assets-fde-01", var.project)
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.assets_locales_frontdoor_profile.id

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_route" "assets_locales_route" {
  name                          = format("%s-assets-cdnr-01", var.project)
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.assets_locales_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.assets_locales_origin_group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.assets_locales_origin.id]
  cdn_frontdoor_rule_set_ids    = [azurerm_cdn_frontdoor_rule_set.assets_locales_ruleset.id]
  cdn_frontdoor_custom_domain_ids = [
    azurerm_cdn_frontdoor_custom_domain.assets_io_pagopa_it.id,
    azurerm_cdn_frontdoor_custom_domain.assets_cdn_io_italia_it.id,
    azurerm_cdn_frontdoor_custom_domain.assets_cdn_io_pagopa_it.id
  ]
  enabled = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  link_to_default_domain = true

  cache {
    query_string_caching_behavior = "IgnoreQueryString"
  }
}

resource "azurerm_monitor_diagnostic_setting" "assets_locales_diagnostic_setting" {
  target_resource_id         = azurerm_cdn_frontdoor_profile.assets_locales_frontdoor_profile.id
  name                       = format("%s-assets-cdnp-01", var.project)
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.diagnostic_settings_storage_account_id

  enabled_log {
    category_group = "allLogs"
    retention_policy {
      days    = 0
      enabled = false
    }
  }

  enabled_metric {
    category = "AllMetrics"
  }
}