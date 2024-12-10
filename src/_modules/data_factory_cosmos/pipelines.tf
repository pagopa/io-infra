resource "azurerm_data_factory_pipeline" "pipeline" {
  for_each        = local.containers_per_database
  name            = replace(each.value.container.name, "/[$-]/", "_")
  data_factory_id = var.data_factory_id
  description     = "Copy data from Cosmos (${var.cosmos_accounts.source.name}) to (${var.cosmos_accounts.target.name})"
  folder          = "cosmos/account=${var.cosmos_accounts.source.name}/db=${each.value.container.database_name}"

  activities_json = jsonencode([
    {
      name = "CopyFromCosmosToCosmos"
      type = "Copy"
      inputs = [
        {
          referenceName = azurerm_data_factory_dataset_cosmosdb_sqlapi.source_dataset[each.key].name
          type          = "DatasetReference"
        }
      ]
      outputs = [
        {
          referenceName = azurerm_data_factory_dataset_cosmosdb_sqlapi.target_dataset[each.key].name
          type          = "DatasetReference"
        }
      ]
      typeProperties = {
        source = {
          type = "CosmosDbSqlApiSource"
        }
        sink = {
          type          = "CosmosDbSqlApiSink"
          writeBehavior = var.cosmos_accounts.target.write_behavior
        }
      }
    }
  ])
}