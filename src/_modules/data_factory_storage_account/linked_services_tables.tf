resource "azurerm_data_factory_linked_service_azure_table_storage" "linked_service_table" {
  for_each        = var.what_to_migrate.table.enabled ? [1] : []
  name            = "${module.naming_convention.prefix}-adf-${var.source_storage_account.name}-st-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id

  connection_string = data.azurerm_storage_account.source.primary_table_endpoint
}