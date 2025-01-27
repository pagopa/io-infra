resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "source_dataset" {
  for_each            = local.containers_per_database
  name                = replace("${var.cosmos_accounts.source.name}-${each.value.container.database_name}-${each.value.container.name}", "/[$-]/", "_")
  data_factory_id     = var.data_factory_id
  folder              = "cosmos/account=${var.cosmos_accounts.source.name}/db=${each.value.container.database_name}/source"
  linked_service_name = azurerm_data_factory_linked_service_cosmosdb.source_linked_service_cosmos[each.value.container.database_id].name
  collection_name     = each.value.container.name
}

resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "target_dataset" {
  for_each            = local.containers_per_database
  name                = replace("${var.cosmos_accounts.target.name}-${each.value.container.database_name}-${each.value.container.name}", "/[$-]/", "_")
  data_factory_id     = var.data_factory_id
  folder              = "cosmos/account=${var.cosmos_accounts.target.name}/db=${each.value.container.database_name}/target"
  linked_service_name = azurerm_data_factory_linked_service_cosmosdb.target_linked_service_cosmos[each.value.container.database_id].name
  collection_name     = each.value.container.name
}