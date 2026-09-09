output "logs_primary_connection_string" {
  value     = try(azurerm_storage_account.logs[0].primary_connection_string, null)
  sensitive = true
}
