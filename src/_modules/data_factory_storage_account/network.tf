resource "azurerm_data_factory_managed_private_endpoint" "blob_source" {
  count              = var.what_to_migrate.blob.enabled ? 1 : 0
  name               = "${module.naming_convention.prefix}-adf-${var.storage_accounts.source.name}-blob-${module.naming_convention.suffix}"
  data_factory_id    = var.data_factory_id
  target_resource_id = data.azurerm_storage_account.source.id
  subresource_name   = "blob"
}

resource "azurerm_data_factory_managed_private_endpoint" "blob_target" {
  count              = var.what_to_migrate.blob.enabled ? 1 : 0
  name               = "${module.naming_convention.prefix}-adf-${var.storage_accounts.target.name}-blob-${module.naming_convention.suffix}"
  data_factory_id    = var.data_factory_id
  target_resource_id = data.azurerm_storage_account.target.id
  subresource_name   = "blob"
}

resource "azurerm_data_factory_managed_private_endpoint" "table_source" {
  count              = var.what_to_migrate.table.enabled ? 1 : 0
  name               = "${module.naming_convention.prefix}-adf-${var.storage_accounts.source.name}-table-${module.naming_convention.suffix}"
  data_factory_id    = var.data_factory_id
  target_resource_id = data.azurerm_storage_account.source.id
  subresource_name   = "table"
}

resource "azurerm_data_factory_managed_private_endpoint" "table_target" {
  count              = var.what_to_migrate.table.enabled ? 1 : 0
  name               = "${module.naming_convention.prefix}-adf-${var.storage_accounts.target.name}-table-${module.naming_convention.suffix}"
  data_factory_id    = var.data_factory_id
  target_resource_id = data.azurerm_storage_account.target.id
  subresource_name   = "table"
}