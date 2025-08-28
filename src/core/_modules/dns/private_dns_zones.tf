resource "azurerm_private_dns_zone" "privatelink_keyvault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name

  tags = var.tags
}
