#tfsec:ignore:azure-storage-default-action-deny
#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "storage_account_legal_backup" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.69.1"

  name                = "${replace(var.project, "-", "")}cgnlegalbackupstorage"
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  blob_versioning_enabled         = false
  account_replication_type        = "GZRS"
  advanced_threat_protection      = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  tags = var.tags
}

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
