resource "azurerm_data_factory_custom_dataset" "source_dataset_table" {
  for_each        = toset(local.tables)
  name            = replace(each.value, "/[$-]/", "_")
  data_factory_id = var.data_factory_id
  type            = "AzureTable"
  folder          = "storage/account=${var.storage_accounts.source.name}/source/table"

  linked_service {
    name = azurerm_data_factory_linked_service_azure_table_storage.source_linked_service_table[0].name
  }

  type_properties_json = jsonencode({
    tableName = each.value
  })
}

resource "azurerm_data_factory_custom_dataset" "target_dataset_table" {
  for_each        = toset(local.tables)
  name            = replace("${module.naming_convention.prefix}-adf-${var.storage_accounts.target.name}-${each.value}-table-${module.naming_convention.suffix}", "/[$-]/", "_")
  data_factory_id = var.data_factory_id
  type            = "AzureTable"
  folder          = "${var.storage_accounts.source.name}/target/table"
  linked_service {
    name = azurerm_data_factory_linked_service_azure_table_storage.target_linked_service_table[0].name
  }

  type_properties_json = jsonencode({
    tableName = each.value
  })
}