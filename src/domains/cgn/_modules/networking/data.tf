data "azurerm_virtual_network" "vnet_common" {
  name                = "${var.project}-vnet-common"
  resource_group_name = local.resource_group_common
}

data "azurerm_subnet" "subnet_private_endpoints" {
  name                 = "pendpoints"
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
}

data "azurerm_nat_gateway" "nat_gateway" {
  name                = "${var.project}-natgw"
  resource_group_name = local.resource_group_common
}
