resource "azurerm_data_factory_custom_dataset" "dataset_container" {
  for_each            = var.datasets
  name                = "${local.prefix}-${local.env_short}-${local.region}-${local.domain}-${local.appname}-${local.azure_data_factory_dataset_container}-${each.value.name}"
  data_factory_id     = azurerm_data_factory.data_factory[each.value.data_factory].id
  type                = each.value.type

  linked_service {
    name       = azurerm_data_factory_linked_service_azure_blob_storage.linked_service_container[each.value.linked_service].name
    parameters = each.value.parameters
  }

  type_properties_json = <<JSON
{
    "linkedServiceName": {
        "referenceName": "${azurerm_data_factory_linked_service_azure_blob_storage.linked_service_container[each.value.linked_service].name}",
        "type": "LinkedServiceReference"
    },
    "type": "AzureBlob",
        "fileName": "${each.value.fileName}",
        "folderPath": "${each.value.folderPath}"
}
JSON
}