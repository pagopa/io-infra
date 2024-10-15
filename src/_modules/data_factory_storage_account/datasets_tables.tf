resource "azurerm_data_factory_custom_dataset" "dataset_table" {
  for_each        = local.tables
  name            = "${module.naming_convention.prefix}-adf-${each.value.name}-table-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id
  type            = "AzureTable"

  linked_service {
    name = azurerm_data_factory_linked_service_azure_blob_storage.linked_service_container[each.key].name
  }

  type_properties_json = jsonencode({
    tableName = each.value.name
  })
}