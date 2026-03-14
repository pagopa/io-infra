output "logs" {
  value = {
    id   = try(azurerm_storage_account.logs.id, null)
    name = try(azurerm_storage_account.logs.name, null)
  }
}