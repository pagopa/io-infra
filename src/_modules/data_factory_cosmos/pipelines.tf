resource "azurerm_data_factory_pipeline" "pipeline" {
  for_each            = local.containers_per_database
  name                = replace("${module.naming_convention.prefix}-adf-${var.cosmos_accounts.source.name}-${each.value.database}-${each.value.container}-cosmos-${module.naming_convention.suffix}", "/[$-]/", "_")
  data_factory_id     = var.data_factory_id
  description         = "Copy data from Cosmos (${var.cosmos_accounts.source.name}) to (${var.cosmos_accounts.target.name})"
  folder              = "${var.cosmos_accounts.source.name}"

  activities_json = jsonencode([
    {
      "name" = "CopyFromCosmosToCosmos"
      "type" = "Copy"
      "inputs" = [
        {
          "referenceName" = azurerm_data_factory_dataset_cosmosdb_sqlapi.source_dataset[each.key].name
          "type"          = "DatasetReference"
        }
      ]
      "outputs" = [
        {
          "referenceName" = azurerm_data_factory_dataset_cosmosdb_sqlapi.target_dataset[each.key].name
          "type"          = "DatasetReference"
        }
      ]
      "typeProperties" = {
        "source" = {
          "type" = "CosmosDbSqlApiSource"
        }
        "sink" = {
          "type" = "CosmosDbSqlApiSink"
        }
      }
    }
  ])
}