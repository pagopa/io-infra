data "azurerm_storage_account" "source" {
  name                = var.storage_accounts.source.name
  resource_group_name = var.storage_accounts.source.resource_group_name
}

data "azurerm_storage_account" "target" {
  name                = var.storage_accounts.target.name
  resource_group_name = var.storage_accounts.target.resource_group_name
}

data "azurerm_storage_containers" "this" {
  for_each = length(var.what_to_migrate.containers) == 0 ? [1] : []
  storage_account_id = data.azurerm_storage_account.source.id
}