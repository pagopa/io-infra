resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "source_dataset" {
  for_each            = local.containers_per_database
  name                = replace("${module.naming_convention.prefix}-adf-${var.cosmos_accounts.source.name}-${each.value.database}-${each.value.container}-cosmos-${module.naming_convention.suffix}", "/[$-]/", "_")
  data_factory_id     = var.data_factory_id
  folder              = "${var.cosmos_accounts.source.name}/source"
  linked_service_name = azurerm_data_factory_linked_service_cosmosdb.source_linked_service_cosmos[each.value.database].name
  collection_name     = each.value.container
}

resource "azurerm_data_factory_dataset_cosmosdb_sqlapi" "target_dataset" {
  for_each            = local.containers_per_database
  name                = replace("${module.naming_convention.prefix}-adf-${var.cosmos_accounts.target.name}-${each.value.database}-${each.value.container}-cosmos-${module.naming_convention.suffix}", "/[$-]/", "_")
  data_factory_id     = var.data_factory_id
  folder              = "${var.cosmos_accounts.target.name}/target"
  linked_service_name = azurerm_data_factory_linked_service_cosmosdb.target_linked_service_cosmos[each.value.database].name
  collection_name     = each.value.container
}