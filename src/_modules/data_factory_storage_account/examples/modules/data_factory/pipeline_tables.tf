resource "azurerm_data_factory_pipeline" "pipeline_table" {
  for_each        = var.pipelines_tables
  name                = "${local.prefix}${local.env_short}${local.region}${local.domain}${local.appname}${local.azure_data_factory_pipeline_table}${each.value.name}"
  data_factory_id = azurerm_data_factory.data_factory[each.value.data_factory].id

  variables = each.value.variables

  depends_on = [
    azurerm_data_factory_custom_dataset.dataset_table
  ]

  activities_json = <<JSON
  [
      {
          "name": "CopyActivity",
          "type": "Copy",
          "dependsOn": [],
          "policy": {
              "timeout": "0.12:00:00",
              "retry": 0,
              "retryIntervalInSeconds": 30,
              "secureOutput": false,
              "secureInput": false
          },
          "userProperties": [],
          "typeProperties": {
              "source": {
                  "type": "AzureTableSource",
                  "azureTableSourceIgnoreTableNotFound": false
              },
              "sink": {
                  "type": "AzureTableSink",
                  "writeBatchSize": 10000,
                  "writeBatchTimeout": "00:00:30"
              },
              "enableStaging": false
          },
          "inputs": [
              {
                  "referenceName": "${each.value.input_dataset}",
                  "type": "DatasetReference"
              }
          ],
          "outputs": [
              {
                  "referenceName": "${each.value.output_dataset}",
                  "type": "DatasetReference"
              }
          ]
      }
  ]
  JSON
}