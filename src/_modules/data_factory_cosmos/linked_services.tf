resource "azurerm_data_factory_linked_service_cosmosdb" "source_linked_service_cosmos" {
  for_each         = local.databases
  name             = "${var.cosmos_accounts.source.name}-${each.value}-cosmos"
  data_factory_id  = var.data_factory_id
  account_endpoint = data.azurerm_cosmosdb_account.source.endpoint
  account_key      = data.azurerm_cosmosdb_account.source.primary_key
  database         = each.value
}

resource "azurerm_data_factory_linked_service_cosmosdb" "target_linked_service_cosmos" {
  for_each         = local.databases
  name             = "${var.cosmos_accounts.target.name}-${each.value}-cosmos"
  data_factory_id  = var.data_factory_id
  account_endpoint = data.azurerm_cosmosdb_account.target.endpoint
  account_key      = data.azurerm_cosmosdb_account.target.primary_key
  database         = each.value
}