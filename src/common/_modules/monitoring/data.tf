data "azurerm_key_vault_secret" "monitor_notification_slack_email" {
  name         = "monitor-notification-slack-email"
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "monitor_notification_email" {
  name         = "monitor-notification-email"
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "alert_error_notification_email" {
  name         = "alert-error-notification-email"
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "alert_error_notification_slack" {
  name         = "alert-error-notification-slack"
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "alert_quarantine_error_notification_slack" {
  name         = "alert-error-quarantine-notification-slack"
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "alert_error_notification_opsgenie" {
  name         = "alert-error-notification-opsgenie"
  key_vault_id = var.kv_id
}
