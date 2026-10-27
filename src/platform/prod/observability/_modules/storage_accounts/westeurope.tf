#trivy:ignore:AZU-0012
#trivy:ignore:AZU-0057
#trivy:ignore:AZU-0061
resource "azurerm_storage_account" "logs" {
  count = var.location == "westeurope" ? 1 : 0

  name                = "iopstlogs"
  resource_group_name = "io-p-rg-operations"

  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "GZRS"

  blob_properties {
    versioning_enabled  = true
    change_feed_enabled = true
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "logs_diagnostic_setting" {

  count = var.location == "westeurope" ? 1 : 0

  depends_on = [azurerm_storage_account.logs]

  target_resource_id         = "${azurerm_storage_account.logs[0].id}/blobServices/default"
  name                       = replace("${var.project}stlogs", "-", "")
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = azurerm_storage_account.logs[0].id

  enabled_log {
    category = "StorageWrite"
  }

  enabled_log {
    category = "StorageDelete"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}
