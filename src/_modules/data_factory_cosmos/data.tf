data "azurerm_subscription" "current" {
}

data "azurerm_cosmosdb_account" "source" {
  name                = var.cosmos_accounts.source.name
  resource_group_name = var.cosmos_accounts.source.resource_group_name
}

data "azurerm_cosmosdb_account" "target" {
  name                = var.cosmos_accounts.target.name
  resource_group_name = var.cosmos_accounts.target.resource_group_name
}

data "azapi_resource_list" "databases" {
  type                   = "Microsoft.DocumentDB/databaseAccounts/databases@2024-05-15"
  parent_id              = data.azurerm_cosmosdb_account.source.id
  response_export_values = ["*"]
}

data "azapi_resource_list" "containers" {
  for_each               = local.databases
  type                   = "Microsoft.DocumentDB/databaseAccounts/apis/databases/containers@2024-05-15"
  parent_id              = "${data.azurerm_cosmosdb_account.source}/databases/${each.value}"
  response_export_values = ["*"]
}