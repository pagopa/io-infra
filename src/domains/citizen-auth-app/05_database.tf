data "azurerm_resource_group" "data_rg" {
  name = format("%s-%s-data-rg", local.product, var.domain)
}

# CITIZEN AUTH
data "azurerm_cosmosdb_account" "cosmos_citizen_auth" {
  name                = format("%s-%s-account", local.product, var.domain)
  resource_group_name = data.azurerm_resource_group.data_rg.name
}

# FIMS
data "azurerm_cosmosdb_account" "cosmosdb_account_mongodb_fims" {
  name                = "io-p-fims-mongodb-account"
  resource_group_name = data.azurerm_resource_group.data_rg.name
}