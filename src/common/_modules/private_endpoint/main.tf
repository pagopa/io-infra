resource "azurerm_private_endpoint" "this" {
  for_each = local.private_endpoints

  name                = "${var.project}-${each.key}-pep-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pep_snet_id

  private_service_connection {
    name                           = "${var.project}-${each.key}-pep-01"
    private_connection_resource_id = each.value.resource_id
    is_manual_connection           = false
    subresource_names              = each.value.subresource_names
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [each.value.private_dns_zone_id]
  }

  tags = var.tags
}