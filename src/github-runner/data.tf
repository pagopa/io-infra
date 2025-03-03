data "azurerm_resource_group" "rg_common" {
  name = var.resource_group_common_name
}

data "azurerm_virtual_network" "vnet_common" {
  name                = var.networking.vnet_common_name
  resource_group_name = data.azurerm_resource_group.rg_common.name
}

data "azurerm_log_analytics_workspace" "law_common" {
  name                = var.law_common_name
  resource_group_name = data.azurerm_resource_group.rg_common.name
}
