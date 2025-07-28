output "app" {
  value = {
    id   = azurerm_storage_account.app.id
    name = azurerm_storage_account.app.name
  }
}

output "app_primary_connection_string" {
  value     = azurerm_storage_account.app.primary_connection_string
  sensitive = true
}

output "logs" {
  value = {
    id   = azurerm_storage_account.logs.id
    name = azurerm_storage_account.logs.name
  }
}

output "logs_primary_connection_string" {
  value     = azurerm_storage_account.logs.primary_connection_string
  sensitive = true
}
