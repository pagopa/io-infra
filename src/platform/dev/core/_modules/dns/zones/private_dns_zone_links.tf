resource "azurerm_private_dns_zone_virtual_network_link" "azure_api_net_vnet_common" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.azure_api_net.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "management_azure_api_net_vnet_common" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.management_azure_api_net.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "scm_azure_api_net_vnet_common" {
  for_each              = var.vnets
  name                  = each.value.name
  resource_group_name   = var.resource_groups.common
  private_dns_zone_name = azurerm_private_dns_zone.scm_azure_api_net.name
  virtual_network_id    = each.value.id
  registration_enabled  = false

  tags = var.tags
}
