data "azurerm_subnet" "pep_snet" {
  name                 = "${var.project}-pep-snet-01"
  resource_group_name  = var.vnet_common.resource_group_name
  virtual_network_name = var.vnet_common.name
}
