# TODO: remove when monitor module is implemented
data "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = var.resource_group_common
  name                = "${replace(var.project, "-", "")}error"
}

data "azurerm_subnet" "function_let_snet" {
  name                 = "fn3eltout"
  resource_group_name  = var.resource_group_common
  virtual_network_name = var.vnet_common.name
}