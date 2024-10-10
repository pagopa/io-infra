output "storage_account_connection_string" {
  value = { for key, account in data.azurerm_storage_account.existing : key => account.primary_connection_string }
}

