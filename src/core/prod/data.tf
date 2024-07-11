data "azurerm_virtual_network" "weu_beta" {
  name                = "${local.project_weu}-beta-vnet"
  resource_group_name = "${local.project_weu}-beta-vnet-rg"
}

data "azurerm_virtual_network" "weu_prod01" {
  name                = "${local.project_weu}-prod01-vnet"
  resource_group_name = "${local.project_weu}-prod01-vnet-rg"
}