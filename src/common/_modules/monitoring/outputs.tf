output "action_groups" {
    value = {
        error = azurerm_monitor_action_group.error.id
        quarantine_error = azurerm_monitor_action_group.quarantine_error.id
        trial_system_error = azurerm_monitor_action_group.trial_system_error.id
        email = azurerm_monitor_action_group.email.id
        slack = azurerm_monitor_action_group.slack.id
    }
}