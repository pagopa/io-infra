data "azurerm_resource_group" "vnet_common_rg" {
  name = var.common_rg
}

# vnet
data "azurerm_virtual_network" "vnet_common" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name
}
