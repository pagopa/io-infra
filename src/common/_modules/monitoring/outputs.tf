output "action_groups" {
  value = {
    error            = azurerm_monitor_action_group.error.id
    quarantine_error = azurerm_monitor_action_group.quarantine_error.id
    email            = azurerm_monitor_action_group.email.id
    slack            = azurerm_monitor_action_group.slack.id
  }
}

output "appi" {
  value = {
    id                  = azurerm_application_insights.appi.id
    name                = azurerm_application_insights.appi.name
    resource_group_name = azurerm_application_insights.appi.resource_group_name
    location            = azurerm_application_insights.appi.location
    reserved_ips        = local.appi_reserved_ips
  }
}

output "appi_instrumentation_key" {
  value     = azurerm_application_insights.appi.instrumentation_key
  sensitive = true
}

output "appi_connection_string" {
  value     = azurerm_application_insights.appi.connection_string
  sensitive = true
}

output "log" {
  value = {
    id                  = azurerm_log_analytics_workspace.log.id
    name                = azurerm_log_analytics_workspace.log.name
    resource_group_name = azurerm_log_analytics_workspace.log.resource_group_name
  }
}
