resource "azurerm_data_factory_custom_dataset" "source_dataset_container" {
  for_each        = local.containers
  name            = "${module.naming_convention.prefix}-adf-${var.storage_accounts.source.name}-${each.value.name}-blob-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id
  type            = "AzureBlob"

  linked_service {
    name = azurerm_data_factory_linked_service_azure_blob_storage.source_linked_service_blob.name
  }

  type_properties_json = jsonencode({
    linkedServiceName = {
      referenceName = azurerm_data_factory_linked_service_azure_blob_storage.source_linked_service_blob.name
      type          = "LinkedServiceReference"
    }
    type       = "AzureBlob"
    folderPath = each.value.name
  })
}

resource "azurerm_data_factory_custom_dataset" "target_dataset_container" {
  for_each        = local.containers
  name            = "${module.naming_convention.prefix}-adf-${var.storage_accounts.target.name}-${each.value.name}-blob-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id
  type            = "AzureBlob"

  linked_service {
    name = azurerm_data_factory_linked_service_azure_blob_storage.target_linked_service_blob.name
  }

  type_properties_json = jsonencode({
    linkedServiceName = {
      referenceName = azurerm_data_factory_linked_service_azure_blob_storage.target_linked_service_blob.name
      type          = "LinkedServiceReference"
    }
    type       = "AzureBlob"
    folderPath = each.value.name
  })
}