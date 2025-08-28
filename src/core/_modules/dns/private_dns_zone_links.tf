resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_keyvault_vnet_common" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_keyvault.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}
