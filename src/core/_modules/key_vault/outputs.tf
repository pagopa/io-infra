output "common_itn" {
  value = {
    id                  = azurerm_key_vault.common_itn_01.id
    name                = azurerm_key_vault.common_itn_01.name
    resource_group_name = azurerm_key_vault.common_itn_01.resource_group_name
  }
}
