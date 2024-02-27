resource "azurerm_private_endpoint" "cgn_legalbackup_storage" {
  name                = format("%s-cgn-legalbackup-storage", local.project)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_pendpoints

  private_service_connection {
    name                           = format("%s-cgn-legalbackup-storage-private-endpoint", local.project)
    private_connection_resource_id = module.cgn_legalbackup_storage.id
    is_manual_connection           = false
    subresource_names              = ["Blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core.id]
  }
}
