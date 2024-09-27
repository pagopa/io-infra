data "azurerm_subnet" "function_elt_snet" {
  name                 = "fn3eltout"
  resource_group_name  = var.resource_group_common
  virtual_network_name = var.vnet_common.name
}
