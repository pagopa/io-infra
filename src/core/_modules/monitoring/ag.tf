resource "azurerm_monitor_action_group" "error" {
  resource_group_name = var.resource_group_common
  name                = local.nonstandard.weu.ag_error
  short_name          = local.nonstandard.weu.ag_error

  email_receiver {
    name                    = "email"
    email_address           = data.azurerm_key_vault_secret.alert_error_notification_email.value
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "slack"
    email_address           = data.azurerm_key_vault_secret.alert_error_notification_slack.value
    use_common_alert_schema = true
  }

  webhook_receiver {
    name                    = "sendtoopsgenie"
    service_uri             = data.azurerm_key_vault_secret.alert_error_notification_opsgenie.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "quarantine_error" {
  resource_group_name = var.resource_group_common
  name                = local.nonstandard.weu.ag_quarantine_error
  short_name          = local.nonstandard.weu.ag_quarantine_error_short

  email_receiver {
    name                    = "slack"
    email_address           = data.azurerm_key_vault_secret.alert_quarantine_error_notification_slack.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

# the action group that publish to the channel of the trial-system project
resource "azurerm_monitor_action_group" "trial_system_error" {
  resource_group_name = var.resource_group_common
  name                = local.nonstandard.weu.ag_ts_error
  short_name          = local.nonstandard.weu.ag_ts_error_short

  email_receiver {
    name                    = "slack"
    email_address           = data.azurerm_key_vault_secret.alert_error_trial_slack.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "email" {
  name                = "EmailPagoPA"
  resource_group_name = var.resource_group_common
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
  resource_group_name = var.resource_group_common
  short_name          = "SlackPagoPA"

  email_receiver {
    name                    = "sendtoslack"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_slack_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}
