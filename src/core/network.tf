data "azurerm_resource_group" "rg_vnet" {
  name = var.common_rg
}

# vnet
data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}