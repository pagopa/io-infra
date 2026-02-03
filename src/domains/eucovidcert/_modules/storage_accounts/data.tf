data "azurerm_monitor_action_group" "status_action_group" {
  name                = "SLACK IO_STATUS"
  resource_group_name = "${local.prefix}-${local.env_short}-rg-common"
}


data "azurerm_monitor_action_group" "operations_action_group" {
  name                = "IO OPERATIONS"
  resource_group_name = "${local.prefix}-${local.env_short}-rg-operations"
}