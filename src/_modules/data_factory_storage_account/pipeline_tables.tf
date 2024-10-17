resource "azurerm_data_factory_pipeline" "pipeline_table" {
  for_each        = toset(local.tables)
  name            = "${module.naming_convention.prefix}-adf-${var.storage_accounts.source.name}-${each.value}-table-${module.naming_convention.suffix}"
  data_factory_id = var.data_factory_id

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
            writeBatchTimeout = "00:02:00"
          }
          enableStaging = false
        }
        inputs = [
          {
            referenceName = azurerm_data_factory_custom_dataset.source_dataset_table[each.value]
            type          = "DatasetReference"
          }
        ]
        outputs = [
          {
            referenceName = azurerm_data_factory_custom_dataset.target_dataset_table[each.value]
            type          = "DatasetReference"
          }
        ]
      }
    ]
  )

}