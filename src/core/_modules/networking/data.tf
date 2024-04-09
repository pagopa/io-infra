data "azurerm_virtual_network" "weu_common" {
  name                = "io-p-vnet-common"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_virtual_network" "weu_beta" {
  name                = "io-p-weu-beta-vnet"
  resource_group_name = "io-p-weu-beta-vnet-rg"
}

data "azurerm_virtual_network" "weu_prod01" {
  name                = "io-p-weu-prod01-vnet"
  resource_group_name = "io-p-weu-prod01-vnet-rg"
}
