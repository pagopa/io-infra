output "kv" {
  value = {
    id                  = azurerm_key_vault.common.id
    name                = azurerm_key_vault.common.name
    resource_group_name = azurerm_key_vault.common.resource_group_name
  }
}

output "kv_common" {
  value = {
    id                  = azurerm_key_vault.kv.id
    name                = azurerm_key_vault.kv.name
    resource_group_name = azurerm_key_vault.kv.resource_group_name
  }
}
