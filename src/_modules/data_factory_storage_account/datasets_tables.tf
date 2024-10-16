resource "azurerm_data_factory_custom_dataset" "source_dataset_table" {
  for_each        = local.tables
  name            = "${module.naming_convention.prefix}-adf-${var.storage_accounts.source.name}-${each.value.name}-table-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory_id
  type            = "AzureTable"

  linked_service {
    name = azurerm_data_factory_linked_service_azure_table_storage.source_linked_service_table[0].name
  }

  type_properties_json = jsonencode({
    tableName = each.value.name
  })
}

resource "azurerm_data_factory_custom_dataset" "target_dataset_table" {
  for_each        = local.tables
  name            = "${module.naming_convention.prefix}-adf-${var.storage_accounts.target.name}-${each.value.name}-table-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory_id
  type            = "AzureTable"

  linked_service {
    name = azurerm_data_factory_linked_service_azure_table_storage.target_linked_service_table[0].name
  }

  type_properties_json = jsonencode({
    tableName = each.value.name
  })
}