output "logs" {
  value = {
    westeurope = {
      id                        = try(azurerm_storage_account.logs[0].id, null)
      name                      = try(azurerm_storage_account.logs[0].name, null)
      primary_connection_string = try(azurerm_storage_account.logs[0].primary_connection_string, null)
      sensitive                 = true
    },
    italynorth = {
      id                        = try(azurerm_storage_account.iopitnlogst01[0].id, null)
      name                      = try(azurerm_storage_account.iopitnlogst01[0].name, null)
      primary_connection_string = try(azurerm_storage_account.iopitnlogst01[0].primary_connection_string, null)
      sensitive                 = true
    }
  }
}
