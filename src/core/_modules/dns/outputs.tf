output "key_vault_private_dns_zone" {
  value = {
    id                  = azurerm_private_dns_zone.privatelink_keyvault.id
    name                = azurerm_private_dns_zone.privatelink_keyvault.name
    resource_group_name = azurerm_private_dns_zone.privatelink_keyvault.resource_group_name
  }
}
