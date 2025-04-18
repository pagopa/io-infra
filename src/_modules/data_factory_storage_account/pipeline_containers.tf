resource "azurerm_data_factory_pipeline" "pipeline_container" {
  for_each        = toset(local.containers)
  name            = replace(each.value, "/[$-]/", "_")
  data_factory_id = var.data_factory_id
  folder          = "storage/account=${var.storage_accounts.source.name}/blob"

  activities_json = jsonencode(
    [
      {
        name      = "CopyActivity"
        type      = "Copy"
        dependsOn = []
        policy = {
          timeout                = "0.12:00:00"
          retry                  = 0
          retryIntervalInSeconds = 30
          secureOutput           = false
          secureInput            = false
        }
        userProperties = []
        typeProperties = {
          source = {
            type = "BinarySource"
            storeSettings = {
              type                     = "AzureBlobStorageReadSettings"
              recursive                = true
              enablePartitionDiscovery = false
              wildcardFileName         = "*" # Copy all files
            }
            formatSettings = {
              type = ""
            }
          }
          sink = {
            type = "BinarySink"
            storeSettings = {
              type = "AzureBlobStorageWriteSettings"
            }
            formatSettings = {
              type = ""
            }
          }
          enableStaging = false
        }
        inputs = [
          {
            referenceName = azurerm_data_factory_custom_dataset.source_dataset_container[each.value].name
            type          = "DatasetReference"
          }
        ]
        outputs = [
          {
            referenceName = azurerm_data_factory_custom_dataset.target_dataset_container[each.value].name
            type          = "DatasetReference"
          }
        ]
      }
    ]
  )
}