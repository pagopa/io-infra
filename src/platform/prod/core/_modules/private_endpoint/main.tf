resource "azurerm_private_endpoint" "this" {
  for_each = merge([
    for pep, instances in local.private_endpoints : {
      for i, values in instances :
      "${pep}-pep-${i}" => values
    }
  ]...)

  name                = "${var.project}-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pep_snet_id

  private_service_connection {
    name                           = "${var.project}-${each.key}"
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
