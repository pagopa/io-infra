# Output block that creates a map of storage account connection strings
# - Uses a for expression to iterate through all existing storage accounts
# - Creates key-value pairs where:
#   * key = the storage account identifier from var.linked_services
#   * value = the primary connection string for that storage account
# - This output can be used by other modules or for reference
# - Note: Connection strings should be handled securely as they contain sensitive information
output "storage_account_connection_string" {
  value = { for key, account in data.azurerm_storage_account.existing : key => account.primary_connection_string }
}