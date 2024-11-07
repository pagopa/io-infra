data "azurerm_virtual_network" "vnet_itn" {
  name                = "${var.project}-itn-common-vnet-01"
  resource_group_name = "${var.project}-itn-common-rg-01"
}

data "azurerm_subnet" "subnet_private_endpoints_itn" {
  name                 = "io-p-itn-pep-snet-01 "
  resource_group_name  = data.azurerm_virtual_network.vnet_itn.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_itn.name
}

data "azurerm_monitor_action_group" "status_action_group" {
  name                = "SLACK IO_STATUS"
  resource_group_name = "${local.prefix}-${local.env_short}-rg-common" 
}


data "azurerm_monitor_action_group" "operations_action_group" {
  name                = "IO OPERATIONS"
  resource_group_name = "${local.prefix}-${local.env_short}-rg-operations" 
}