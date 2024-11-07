
##############################
# Locked User Profiles Storage
##############################
module "locked_profiles_storage" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v8.27.0"

  name                          = replace(format("%s-locked-profiles-st", local.product), "-", "")
  domain                        = "IO-AUTH"
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  access_tier                   = "Hot"
  account_replication_type      = "GZRS"
  resource_group_name           = "${local.product}-rg-internal"
  location                      = var.location
  advanced_threat_protection    = true
  enable_identity               = true
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "locked_profiles_storage_table" {
  depends_on          = [module.locked_profiles_storage]
  name                = "${module.locked_profiles_storage.name}-table-endpoint"
  location            = var.location
  resource_group_name = "${local.product}-rg-internal"
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "${module.locked_profiles_storage.name}-table"
    private_connection_resource_id = module.locked_profiles_storage.id
    is_manual_connection           = false
    subresource_names              = ["table"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id]
  }

  tags = var.tags
}

# Tables
resource "azurerm_storage_table" "locked_profiles" {
  depends_on           = [azurerm_private_endpoint.locked_profiles_storage_table]
  name                 = "lockedprofiles"
  storage_account_name = module.locked_profiles_storage.name
}


module "azure_storage_account" {
  source = "github.com/pagopa/dx//infra/modules/azure_storage_account?ref=main"

  environment         = local.itn_environment
  resource_group_name = azurerm_resource_group.rg_internal.name
  tier                = "l"
  subnet_pep_id                        = data.azurerm_subnet.subnet_pep_itn.id
  private_dns_zone_resource_group_name = "${local.prefix}-${local.env_short}-rg-common"
  
  subservices_enabled = {
    blob  = false
    file  = false
    queue  = false
    table  = true
  }

  force_public_network_access_enabled = false

  tags = var.tags
}