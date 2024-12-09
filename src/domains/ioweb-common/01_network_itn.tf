data "azurerm_virtual_network" "common_itn" {
  name                = "${local.common_project_itn}-common-vnet-01"
  resource_group_name = "${local.common_project_itn}-common-rg-01"
}

data "azurerm_subnet" "private_endpoints_subnet_itn" {
  name                 = "${local.common_project_itn}-pep-snet-01"
  virtual_network_name = data.azurerm_virtual_network.common_itn.name
  resource_group_name  = data.azurerm_virtual_network.common_itn.resource_group_name
}
