resource "azurerm_private_endpoint" "private_endpoint_storage_account_legal_backup" {
  name                = "${var.project}-cgn-legalbackup-storage"
  location            = var.location
  resource_group_name = module.storage_account_legal_backup.resource_group_name
  subnet_id           = var.subnet_pendpoints_id

  private_service_connection {
    name                           = "${var.project}-cgn-legalbackup-storage-private-endpoint"
    private_connection_resource_id = module.storage_account_legal_backup.id
    is_manual_connection           = false
    subresource_names              = ["Blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core.id]
  }
}
