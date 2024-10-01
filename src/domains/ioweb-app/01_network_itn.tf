data "azurerm_virtual_network" "common_vnet_italy_north" {
  name                = format("%s-itn-common-vnet-01", local.product)
  resource_group_name = data.azurerm_resource_group.italy_north_common_rg.name
}

data "azurerm_subnet" "function_profile_snet" {
  count                = 2
  name                 = format("%s-itn-auth-profile-snet-0%d", local.product, count.index + 1)
  virtual_network_name = data.azurerm_virtual_network.common_vnet_italy_north.name
  resource_group_name  = data.azurerm_virtual_network.common_vnet_italy_north.resource_group_name
}
