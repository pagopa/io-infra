module "storage_account_cosmos_backup" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v8.36.1"

  name                = "${replace(var.project, "-", "")}stcosmosbonusbackup"
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind                         = "StorageV2"
  account_tier                         = "Standard"
  access_tier                          = "Cool"
  account_replication_type             = "GRS"
  public_network_access_enabled        = false
  allow_nested_items_to_be_public      = true
  use_legacy_defender_version          = false
  blob_container_delete_retention_days = 7
  blob_delete_retention_days           = 7

  enable_low_availability_alert = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "storage_account_cosmos_backup_blob_pep" {
  name                = "${module.storage_account_cosmos_backup.name}-blob-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_pendpoints_id

  private_service_connection {
    name                           = "${module.storage_account_cosmos_backup.name}-blob-endpoint"
    private_connection_resource_id = module.storage_account_cosmos_backup.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "storage_account_cosmos_backup_queue_pep" {
  name                = "${module.storage_account_cosmos_backup.name}-queue-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_pendpoints_id

  private_service_connection {
    name                           = "${module.storage_account_cosmos_backup.name}-queue-endpoint"
    private_connection_resource_id = module.storage_account_cosmos_backup.id
    is_manual_connection           = false
    subresource_names              = ["queue"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_queue_core.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "storage_account_cosmos_backup_table_pep" {
  name                = "${module.storage_account_cosmos_backup.name}-table-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_pendpoints_id

  private_service_connection {
    name                           = "${module.storage_account_cosmos_backup.name}-table-endpoint"
    private_connection_resource_id = module.storage_account_cosmos_backup.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_core.id]
  }

  tags = var.tags
}
