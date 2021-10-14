resource "azurerm_dns_zone" "io_public" {
  count               = (var.dns_zone_io == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_io, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}
