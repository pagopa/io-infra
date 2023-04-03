data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = var.application_insights_name
  resource_group_name = var.monitor_resource_group_name
}

data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = var.monitor_resource_group_name
  name                = "${var.prefix}${var.env_short}error"
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appinsights_instrumentation_key" {
  name         = "appinsights-instrumentation-key"
  value        = data.azurerm_application_insights.application_insights.instrumentation_key
  content_type = "only instrumentation key"

  key_vault_id = module.key_vault.id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appinsights_connection_string" {
  name         = "appinsights-connection-string"
  value        = data.azurerm_application_insights.application_insights.connection_string
  content_type = "full connection string, example InstrumentationKey=XXXXX"

  key_vault_id = module.key_vault.id
}
