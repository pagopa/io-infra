output "action_groups" {
  value = {
    error              = azurerm_monitor_action_group.error.id
    quarantine_error   = azurerm_monitor_action_group.quarantine_error.id
    trial_system_error = azurerm_monitor_action_group.trial_system_error.id
    email              = azurerm_monitor_action_group.email.id
    slack              = azurerm_monitor_action_group.slack.id
  }
}

output "appi" {
  value = {
    id                  = azurerm_application_insights.appi.id
    name                = azurerm_application_insights.appi.name
    resource_group_name = azurerm_application_insights.appi.resource_group_name
  }
}

output "appi_instrumentation_key" {
  value     = azurerm_application_insights.appi.instrumentation_key
  sensitive = true
}
