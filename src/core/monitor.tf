data "azurerm_resource_group" "monitor_rg" {
  name = var.common_rg
}

data "azurerm_log_analytics_workspace" "monitor_rg" {
  name                = var.log_analytics_workspace_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

# Application insights
data "azurerm_application_insights" "application_insights" {
  name                = var.application_insights_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "email" {
  name                = var.monitor_action_group_email_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_monitor_action_group" "slack" {
  name                = var.monitor_action_group_slack_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}