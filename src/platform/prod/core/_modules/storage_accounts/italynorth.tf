#trivy:ignore:AZU-0012
#trivy:ignore:AZU-0057
#trivy:ignore:AZU-0061
resource "azurerm_storage_account" "iopitndataexportst01" {

  count = var.location == "italynorth" ? 1 : 0

  name                     = replace("${var.project}dataexportst01", "-", "")
  resource_group_name      = var.resource_group_operations
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS" # GZRS not available at the moment in ITN

  public_network_access_enabled    = false
  shared_access_key_enabled        = true
  allow_nested_items_to_be_public  = false
  large_file_share_enabled         = false
  cross_tenant_replication_enabled = true

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "iopitndataexportst01_diagnostic_setting" {

  count = var.location == "italynorth" ? 1 : 0

  depends_on = [azurerm_storage_account.iopitndataexportst01]

  target_resource_id         = azurerm_storage_account.iopitndataexportst01[0].id
  name                       = replace("${var.project}dataexportst01", "-", "")
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.diagnostic_settings_storage_account_id

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}
