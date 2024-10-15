data "azurerm_storage_containers" "this" {
  for_each = length(var.containers) == 0 ? [1] : []
  storage_account_id = var.source_storage_account.id
}

data "azurerm_storage_account" "source" {
  name                = var.source_storage_account.name
  resource_group_name = var.source_storage_account.resource_group_name
}