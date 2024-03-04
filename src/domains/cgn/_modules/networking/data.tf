data "azurerm_virtual_network" "vnet_common" {
  name                = "${var.project}-vnet-common"
  resource_group_name = local.resource_group_common
}

data "azurerm_nat_gateway" "nat_gateway" {
  name                = "${var.project}-natgw"
  resource_group_name = local.resource_group_common
}
