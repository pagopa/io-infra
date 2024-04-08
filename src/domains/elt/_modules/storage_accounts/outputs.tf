output "storage_account_elt" {
  value = {
    id   = module.storage_account_elt.id
    name = module.storage_account_elt.name
  }
}

output "storage_account_elt_primary_access_key" {
  value     = module.storage_account_elt.primary_access_key
  sensitive = true
}

output "storage_account_elt_primary_connection_string" {
  value     = module.storage_account_elt.primary_connection_string
  sensitive = true
}

output "storage_account_tables" {
  value = {
    fnelterrors                     = azurerm_storage_table.fnelterrors.name
    fnelterrors_messages            = azurerm_storage_table.fnelterrors_messages.name
    fnelterrors_message_status      = azurerm_storage_table.fnelterrors_message_status.name
    fnelterrors_notification_status = azurerm_storage_table.fnelterrors_notification_status.name
    fneltcommands                   = azurerm_storage_table.fneltcommands.name
    fneltexports                    = azurerm_storage_table.fneltexports.name
  }
}

output "storage_account_containers" {
  value = {
    container_messages_report_step1      = azurerm_storage_container.container_messages_report_step1.name
    container_messages_report_step_final = azurerm_storage_container.container_messages_report_step_final.name
  }
}
