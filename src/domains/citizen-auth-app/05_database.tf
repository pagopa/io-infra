data "azurerm_resource_group" "data_rg" {
  name = format("%s-%s-data-rg", local.product, var.domain)
}

data "azurerm_resource_group" "data_rg_itn" {
  name = "${local.project_itn}-data-rg-01"
}

# CITIZEN AUTH
data "azurerm_cosmosdb_account" "cosmos_citizen_auth" {
  name                = format("%s-%s-account", local.product, var.domain)
  resource_group_name = data.azurerm_resource_group.data_rg.name
}

# COMMON
data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.product)
  resource_group_name = data.azurerm_resource_group.rg_internal.name
}
