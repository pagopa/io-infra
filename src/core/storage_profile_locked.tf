
##############################
# Locked User Profiles Storage
##############################
module "locked_profiles_storage" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v6.1.0"

  name                          = replace(format("%s-locked-profiles-st", local.project), "-", "")
  domain                        = "IO-AUTH"
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  access_tier                   = "Hot"
  account_replication_type      = "GZRS"
  resource_group_name           = azurerm_resource_group.rg_internal.name
  location                      = azurerm_resource_group.rg_internal.location
  advanced_threat_protection    = true
  enable_identity               = true
  public_network_access_enabled = false

  tags = var.tags
}


resource "azurerm_private_endpoint" "locked_profiles_storage_table" {
  depends_on          = [module.locked_profiles_storage]
  name                = "${module.locked_profiles_storage.name}-table-endpoint"
  location            = azurerm_resource_group.rg_internal.location
  resource_group_name = azurerm_resource_group.rg_internal.location
  subnet_id           = var.internal_storage.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${module.locked_profiles_storage.name}-table"
    private_connection_resource_id = module.locked_profiles_storage.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_table_core.id]
  }

  tags = var.tags
}


# Tables
resource "azurerm_storage_table" "locked_profiles" {
  depends_on           = [azurerm_private_endpoint.locked_profiles_storage_table]
  name                 = "locked_profiles"
  storage_account_name = module.locked_profiles_storage.name
}
