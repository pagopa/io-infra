#trivy:ignore:AZU-0012
#trivy:ignore:AZU-0057
#trivy:ignore:AZU-0061
resource "azurerm_storage_account" "app" {
  count = var.location == "westeurope" ? 1 : 0

  name                = "iopstapp"
  resource_group_name = "io-p-rg-internal"

  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "GZRS"

  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "app_diagnostic_setting" {

  count = var.location == "westeurope" ? 1 : 0

  depends_on = [azurerm_storage_account.app]

  target_resource_id         = azurerm_storage_account.app[0].id
  name                       = replace("${var.project}stapp", "-", "")
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.diagnostic_settings_storage_account_id

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}

#trivy:ignore:AZU-0012
#trivy:ignore:AZU-0057
#trivy:ignore:AZU-0061
resource "azurerm_storage_account" "exportdata_weu_01" {
  count = var.location == "westeurope" ? 1 : 0

  name                     = replace("${var.project}stexportdata", "-", "")
  resource_group_name      = var.resource_group_operations
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GZRS"

  public_network_access_enabled    = true
  shared_access_key_enabled        = true
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "exportdata_weu_01_diagnostic_setting" {

  depends_on = [azurerm_storage_account.exportdata_weu_01]

  target_resource_id         = azurerm_storage_account.exportdata_weu_01[0].id
  name                       = replace("${var.project}stexportdata", "-", "")
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.diagnostic_settings_storage_account_id

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}
