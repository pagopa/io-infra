resource "azurerm_data_factory_pipeline" "pipeline_container" {
  for_each        = local.containers
  name            = "${module.naming_convention.prefix}-adf-${each.value.name}-blob-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id

  variables = each.value.variables

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
              wildcardFileName         = each.value.wildcard_file_name
            }
            formatSettings = {
              type = "JsonReadSettings"
            }
          }
          sink = {
            type = "JsonSink"
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
            referenceName = each.value.input_dataset
            type          = "DatasetReference"
          }
        ]
        outputs = [
          {
            referenceName = each.value.output_dataset
            type          = "DatasetReference"
          }
        ]
      }
    ]
  )
}