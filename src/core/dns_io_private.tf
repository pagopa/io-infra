resource "azurerm_private_dns_zone" "io_private" {
  count               = (var.dns_zone_io == null || var.external_domain == null) ? 0 : 1
  name                = join(".", ["internal", var.dns_zone_io, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "io_private_vnet_common" {
  name                  = format("%s-private-vnet-common", local.project)
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.io_private[0].name
  virtual_network_id    = data.azurerm_virtual_network.vnet_common.id
}

# TODO add vnet p2s
# resource "azurerm_private_dns_zone_virtual_network_link" "io_private_vnet_common" {
#   name                  = format("%s-private-vnet-common", local.project)
#   resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
#   private_dns_zone_name = azurerm_private_dns_zone.io_private[0].name
#   virtual_network_id    = data.azurerm_virtual_network.vnet_common.id
# }

# api-app.internal.io.pagopa.it
# api-app.internal.dev.io.pagopa.it
resource "azurerm_private_dns_a_record" "api_app_io_private" {
  name                = "api-app"
  zone_name           = azurerm_private_dns_zone.io_private[0].name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  ttl                 = var.dns_default_ttl_sec
  records             = module.apim.*.private_ip_addresses[0]
}
