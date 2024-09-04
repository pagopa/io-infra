data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", local.project)
  resource_group_name = azurerm_resource_group.rg_common.name
}

data "azurerm_monitor_action_group" "error_action_group" {
  name                = format("%s-ai-common", local.project)
  resource_group_name = azurerm_resource_group.rg_common.name
}
