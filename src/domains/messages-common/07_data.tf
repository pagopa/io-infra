data "azurerm_resource_group" "notification_rg" {
  name = "${local.prefix}-${local.env_short}-${local.location}-messages-notifications-rg"
}

data "azurerm_virtual_network" "vnet_itn" {
  name                = "${local.prefix}-${local.env_short}-itn-common-vnet-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-common-rg-01"
}

data "azurerm_subnet" "subnet_pep_itn" {
  name                 = "io-p-itn-pep-snet-01 "
  resource_group_name  = data.azurerm_virtual_network.vnet_itn.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_itn.name
}