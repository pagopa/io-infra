data "azurerm_storage_account" "immutable_spid_logs_storage" {
  name                = replace(format("%s-%s-spid-logs-im-st", local.common_project, var.domain), "-", "")
  resource_group_name = data.azurerm_resource_group.storage_rg.name
}

# Containers
data "azurerm_storage_container" "immutable_audit_logs" {
  name                 = "auditlogs"
  storage_account_name = data.azurerm_storage_account.immutable_spid_logs_storage.name
}
