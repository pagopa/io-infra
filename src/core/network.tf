resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_resource_group" "vnet_common_rg" {
  name = var.common_rg
}

# vnet
data "azurerm_virtual_network" "vnet_common" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name
}
