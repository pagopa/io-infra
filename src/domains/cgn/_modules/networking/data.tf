data "azurerm_virtual_network" "vnet_common" {
  name                = "${var.project}-vnet-common"
  resource_group_name = local.resource_group_common
}

data "azurerm_virtual_network" "common_itn" {
  name                = "${var.project}-itn-common-vnet-01"
  resource_group_name = local.resource_group_common_itn
}

data "azurerm_subnet" "subnet_private_endpoints" {
  name                 = "pendpoints"
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
}

data "azurerm_subnet" "pep_snet_itn" {
  name                 = "${var.project}-itn-pep-snet-01"
  resource_group_name  = data.azurerm_virtual_network.common_itn.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.common_itn.name
}

data "azurerm_nat_gateway" "nat_gateway" {
  name                = "${var.project}-natgw"
  resource_group_name = local.resource_group_common
}
