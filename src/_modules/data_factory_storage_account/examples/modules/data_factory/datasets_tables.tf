resource "azurerm_data_factory_custom_dataset" "dataset_table" {
  for_each        = var.datasets_tables
  name                = "${local.prefix}-${local.env_short}-${local.region}-${local.domain}-${local.appname}-${local.azure_data_factory_dataset_table}-${each.value.name}"
  data_factory_id = azurerm_data_factory.data_factory[each.value.data_factory].id
  type            = "AzureTable"

  linked_service {
    name = azurerm_data_factory_linked_service_azure_table_storage.linked_service_table[each.value.linked_service].name
  }

  type_properties_json = jsonencode({
    tableName = each.value.table_name
  })
}