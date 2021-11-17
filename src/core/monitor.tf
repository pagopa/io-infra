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

data "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = format("%s-law-common", local.project)
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_key_vault_secret" "monitor_notification_slack_email" {
  name         = "monitor-notification-slack-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_notification_email" {
  name         = "monitor-notification-email"
  key_vault_id = module.key_vault.id
}

resource "azurerm_monitor_action_group" "email" {
  name                = "EmailPagoPA"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  short_name          = "EmailPagoPA"

  email_receiver {
    name                    = "sendtooperations"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "slack" {
  name                = "SlackPagoPA"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  short_name          = "SlackPagoPA"

  email_receiver {
    name                    = "sendtoslack"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_slack_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}
