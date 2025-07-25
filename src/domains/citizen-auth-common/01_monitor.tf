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

data "azurerm_monitor_action_group" "quarantine_error_action_group" {
  resource_group_name = var.monitor_resource_group_name
  name                = "${var.prefix}${var.env_short}quarantineerror"
}

data "azurerm_monitor_action_group" "auth_n_identity_error_action_group" {
  resource_group_name = "io-p-itn-auth-common-rg-01"
  name                = "io-p-itn-auth-error-ag-01"
}

removed {
  from = azurerm_key_vault_secret.appinsights_instrumentation_key
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.appinsights_connection_string
  lifecycle {
    destroy = false
  }
}
