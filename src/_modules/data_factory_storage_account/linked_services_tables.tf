resource "azurerm_data_factory_linked_service_azure_table_storage" "source_linked_service_table" {
  count           = var.what_to_migrate.table.enabled ? 1 : 0
  name            = "${module.naming_convention.prefix}-adf-${var.storage_accounts.source.name}-table-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory_id

  connection_string = data.azurerm_storage_account.source.primary_table_endpoint
}

resource "azurerm_data_factory_linked_service_azure_table_storage" "target_linked_service_table" {
  count           = var.what_to_migrate.table.enabled ? 1 : 0
  name            = "${module.naming_convention.prefix}-adf-${var.storage_accounts.target.name}-table-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory_id

  connection_string = data.azurerm_storage_account.target.primary_table_endpoint
}