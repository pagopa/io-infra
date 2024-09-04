resource "azurerm_monitor_action_group" "error" {
  resource_group_name = var.resource_group_common
  name                = try(local.nonstandard[var.location_short].ag_error, "${var.project}-error-ag-01")
  short_name          = try(local.nonstandard[var.location_short].ag_error, "${var.project}-error-ag-01")

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
  name                = try(local.nonstandard[var.location_short].ag_quarantine_error, "${var.project}-quarantineerror-ag-01")
  short_name          = try(local.nonstandard[var.location_short].ag_quarantine_error_short, "${var.project}-qerr-ag-01")

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
  name                = try(local.nonstandard[var.location_short].ag_ts_error, "${var.project}-ts-error-ag-01")
  short_name          = try(local.nonstandard[var.location_short].ag_ts_error_short, "${var.project}-ts-error-ag-01")

  email_receiver {
    name                    = "slack"
    email_address           = data.azurerm_key_vault_secret.alert_error_trial_slack.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "email" {
  name                = try(local.nonstandard[var.location_short].email_pagopa, "${var.project}-email-ag-01")
  resource_group_name = var.resource_group_common
  short_name          = try(local.nonstandard[var.location_short].email_pagopa, "${var.project}-email-ag-01")

  email_receiver {
    name                    = "sendtooperations"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "slack" {
  name                = try(local.nonstandard[var.location_short].slack_pagopa, "${var.project}-slack-ag-01")
  resource_group_name = var.resource_group_common
  short_name          = try(local.nonstandard[var.location_short].slack_pagopa, "${var.project}-slack-ag-01")

  email_receiver {
    name                    = "sendtoslack"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_slack_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}
