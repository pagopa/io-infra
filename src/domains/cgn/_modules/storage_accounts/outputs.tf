output "storage_account_connection_string" {
  value = data.azurerm_storage_account.iopstcgn.primary_connection_string
}
