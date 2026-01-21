resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings_cdn_frontdoor" {
  name                       = "${azurerm_cdn_frontdoor_profile.cdn_profile.name}-cdn-profile-diagnostic-settings"
  target_resource_id         = azurerm_cdn_frontdoor_profile.cdn_profile.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category_group = "allLogs"
  }

  metric {
    category = "AllMetrics"
  }
}