data "azurerm_storage_account" "source" {
  name                = var.storage_accounts.source.name
  resource_group_name = var.storage_accounts.source.resource_group_name
}

data "azurerm_storage_account" "target" {
  name                = var.storage_accounts.target.name
  resource_group_name = var.storage_accounts.target.resource_group_name
}

data "azurerm_storage_containers" "this" {
  count              = var.what_to_migrate.blob.enabled && length(var.what_to_migrate.blob.containers) == 0 ? 1 : 0
  storage_account_id = data.azurerm_storage_account.source.id
}

data "azapi_resource_list" "tables" {
  type                   = "Microsoft.Storage/storageAccounts/tableServices/tables@2021-09-01"
  parent_id              = "${data.azurerm_storage_account.source.id}/tableServices/default"
  response_export_values = ["*"]
}