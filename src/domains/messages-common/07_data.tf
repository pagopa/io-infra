data "azurerm_virtual_network" "vnet_itn" {
  name                = "${var.prefix}-${var.env_short}-itn-common-vnet-01"
  resource_group_name = "${var.prefix}-${var.env_short}-itn-common-rg-01"
}

data "azurerm_subnet" "subnet_pep_itn" {
  name                 = "io-p-itn-pep-snet-01 "
  resource_group_name  = data.azurerm_virtual_network.vnet_itn.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_itn.name
}