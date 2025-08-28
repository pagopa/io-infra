resource "azurerm_private_endpoint" "common_kv_itn_01" {
  name                = "${var.project}-common-kv-pep-01"
  location            = azurerm_key_vault.common_itn_01.location
  resource_group_name = azurerm_key_vault.common_itn_01.resource_group_name

  subnet_id = var.subnet_pep_id

  private_service_connection {
    name                           = "${var.project}-common-kv-pep-01"
    private_connection_resource_id = azurerm_key_vault.common_itn_01.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags
}
