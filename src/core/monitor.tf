data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", local.project)
  resource_group_name = azurerm_resource_group.rg_common.name
}

data "azurerm_monitor_action_group" "error_action_group" {
  name                = "${var.prefix}${var.env_short}error"
  resource_group_name = azurerm_resource_group.rg_common.name
}

data "azurerm_monitor_action_group" "io_com_action_group" {
  name                = "io-p-com-error-ag-01"
  resource_group_name = "io-p-itn-msgs-rg-01"
}
