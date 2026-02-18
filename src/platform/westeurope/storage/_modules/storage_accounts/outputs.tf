output "app" {
  value = {
    id   = try(azurerm_storage_account.app.id, null)
    name = try(azurerm_storage_account.app.name, null)
  }
}

output "app_primary_connection_string" {
  value     = try(azurerm_storage_account.app.primary_connection_string, null)
  sensitive = true
}

output "logs" {
  value = {
    id   = try(azurerm_storage_account.logs.id, null)
    name = try(azurerm_storage_account.logs.name, null)
  }
}

output "logs_primary_connection_string" {
  value     = try(azurerm_storage_account.logs.primary_connection_string, null)
  sensitive = true
}