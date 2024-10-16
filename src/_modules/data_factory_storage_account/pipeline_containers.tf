resource "azurerm_data_factory_pipeline" "pipeline_container" {
  for_each        = local.containers
  name            = "${module.naming_convention.prefix}-adf-${each.value.name}-blob-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id

  depends_on = [
    azurerm_data_factory_custom_dataset.dataset_container
  ]

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
            type = "JsonSource"
            storeSettings = {
              type                     = "AzureBlobStorageReadSettings"
              recursive                = true
              enablePartitionDiscovery = false
              wildcardFileName         = "*" # Copy all files
            }
            formatSettings = {
              type = "JsonReadSettings"
            }
          }
          sink = {
            type = "JsonSink" # Check for binary
            storeSettings = {
              type = "AzureBlobStorageWriteSettings"
            }
            formatSettings = {
              type = "JsonWriteSettings"
            }
          }
          enableStaging = false
        }
        inputs = [
          {
            referenceName = azurerm_data_factory_custom_dataset.source_dataset_container
            type          = "DatasetReference"
          }
        ]
        outputs = [
          {
            referenceName = azurerm_data_factory_custom_dataset.target_dataset_container
            type          = "DatasetReference"
          }
        ]
      }
    ]
  )
}