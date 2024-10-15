resource "azurerm_data_factory_custom_dataset" "dataset_container" {
  for_each        = local.containers
  name            = "${module.naming_convention.prefix}-adf-${each.value.name}-blob-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id
  type            = "AzureBlob"

  linked_service {
    name = azurerm_data_factory_linked_service_azure_blob_storage.linked_service_container[each.key].name
    # parameters = each.value.parameters
  }

  type_properties_json = jsonencode({
    linkedServiceName = {
      referenceName = azurerm_data_factory_linked_service_azure_blob_storage.linked_service_container[each.key].name
      type          = "LinkedServiceReference"
    }
    type       = "AzureBlob"
    fileName   = each.value.file_name
    folderPath = each.value.folder_path
  })
}