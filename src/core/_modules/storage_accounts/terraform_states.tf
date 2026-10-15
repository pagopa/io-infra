#trivy:ignore:AZU-0012
#trivy:ignore:AZU-0061
#trivy:ignore:AZU-0057
#trivy:ignore:AZU-0058
resource "azurerm_storage_account" "terraform_state_itn" {

  name                = replace("${var.project}tfst001", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = "Standard"
  access_tier              = "Hot"
  account_kind             = "StorageV2"
  account_replication_type = "ZRS"

  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "terraform_state_itn_diagnostic_setting" {
  target_resource_id         = azurerm_storage_account.terraform_state_itn.id
  name                       = replace("${var.project}tfst001", "-", "")
  log_analytics_workspace_id = var.log_analytics_workspace_id
  storage_account_id         = var.diagnostic_settings_storage_account_id

  enabled_log {
    category_group = "allLogs"
  }

  enabled_metric {
    category = "AllMetrics"
  }
}
