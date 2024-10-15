resource "azurerm_data_factory_pipeline" "pipeline_table" {
  for_each        = local.tables
  name            = "${module.naming_convention.prefix}-adf-${each.value.name}-table-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory.id

  variables = each.value.variables

  depends_on = [
    azurerm_data_factory_custom_dataset.dataset_table
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
            type                                = "AzureTableSource"
            azureTableSourceIgnoreTableNotFound = false
          }
          sink = {
            type              = "AzureTableSink"
            writeBatchSize    = 10000
            writeBatchTimeout = "00:00:30"
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