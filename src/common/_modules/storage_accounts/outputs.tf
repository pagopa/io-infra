output "app" {
  value = {
    id   = try(azurerm_storage_account.app[0].id, null)
    name = try(azurerm_storage_account.app[0].name, null)
  }
}

output "app_primary_connection_string" {
  value     = try(azurerm_storage_account.app[0].primary_connection_string, null)
  sensitive = true
}

output "logs" {
  value = {
    id   = try(azurerm_storage_account.logs[0].id, null)
    name = try(azurerm_storage_account.logs[0].name, null)
  }
}

output "logs_primary_connection_string" {
  value     = try(azurerm_storage_account.logs[0].primary_connection_string, null)
  sensitive = true
}

output "logs_itn" {
  value = {
    id   = try(azurerm_storage_account.logs[1].id, null)
    name = try(azurerm_storage_account.logs[1].name, null)
  }
}