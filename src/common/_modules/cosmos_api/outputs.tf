output "endpoint" {
  value = azurerm_cosmosdb_account.this.endpoint
}

output "primary_key" {
  value     = azurerm_cosmosdb_account.this.primary_key
  sensitive = true
}

output "connection_string" {
  value     = format("AccountEndpoint=%s;AccountKey=%s;", azurerm_cosmosdb_account.this.endpoint, azurerm_cosmosdb_account.this.primary_key)
  sensitive = true
}
