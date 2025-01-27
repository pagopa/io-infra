resource "azurerm_data_factory_custom_dataset" "source_dataset_container" {
  for_each        = toset(local.containers)
  name            = replace("${var.storage_accounts.source.name}-${each.value}-blob", "/[$-]/", "_")
  data_factory_id = var.data_factory_id
  type            = "AzureBlob"
  folder          = "storage/account=${var.storage_accounts.source.name}/source/blob"

  linked_service {
    name = azurerm_data_factory_linked_service_azure_blob_storage.source_linked_service_blob[0].name
  }

  type_properties_json = jsonencode({
    linkedServiceName = {
      referenceName = azurerm_data_factory_linked_service_azure_blob_storage.source_linked_service_blob[0].name
      type          = "LinkedServiceReference"
    }
    type       = "AzureBlob"
    folderPath = each.value
  })
}

resource "azurerm_data_factory_custom_dataset" "target_dataset_container" {
  for_each        = toset(local.containers)
  name            = replace("${var.storage_accounts.target.name}-${each.value}-blob", "/[$-]/", "_")
  data_factory_id = var.data_factory_id
  type            = "AzureBlob"
  folder          = "${var.storage_accounts.source.name}/target/blob"

  linked_service {
    name = azurerm_data_factory_linked_service_azure_blob_storage.target_linked_service_blob[0].name
  }

  type_properties_json = jsonencode({
    linkedServiceName = {
      referenceName = azurerm_data_factory_linked_service_azure_blob_storage.target_linked_service_blob[0].name
      type          = "LinkedServiceReference"
    }
    type       = "AzureBlob"
    folderPath = each.value
  })
}