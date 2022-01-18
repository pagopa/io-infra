data "azurerm_resource_group" "cgn" {
  name = format("%s-rg-cgn", local.project)
}

## redis cgn subnet
module "redis_cgn_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.26"
  name                                           = format("%s-redis-cgn-snet", local.project)
  address_prefixes                               = ["10.0.14.0/25"]
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true
}

module "redis_cgn" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v2.0.26"
  name                  = format("%s-redis-cgn-std", local.project)
  resource_group_name   = data.azurerm_resource_group.cgn.name
  location              = data.azurerm_resource_group.cgn.location
  capacity              = 1
  family                = "C"
  sku_name              = "Standard"
  enable_authentication = true

  // when azure can apply patch?
  patch_schedules = [{
    day_of_week    = "Sunday"
    start_hour_utc = 23
    },
    {
      day_of_week    = "Monday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Tuesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Wednesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Thursday"
      start_hour_utc = 23
    },
  ]


  private_endpoint = {
    enabled              = true
    virtual_network_id   = data.azurerm_virtual_network.vnet_common.id
    subnet_id            = module.redis_cgn_snet.id
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_redis_cache.id]
  }

  tags = var.tags
}

data "azurerm_subnet" "fn3cgn" {
  name                 = "fn3cgn"
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
}

##################
## CosmosDB cgn ##
##################

module "cosmos_cgn" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.1.1"
  name     = format("%s-cosmos-cgn", local.project)
  location = var.location

  resource_group_name = data.azurerm_resource_group.cgn.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  main_geo_location_zone_redundant = false

  enable_free_tier          = false
  enable_automatic_failover = true


  consistency_policy = {
    consistency_level       = "Strong"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  main_geo_location_location = "westeurope"

  additional_geo_locations = [
    {
      location          = "northeurope"
      failover_priority = 1
      zone_redundant    = true
    }
  ]

  backup_continuous_enabled = true

  is_virtual_network_filter_enabled = true

  ip_range = ""

  allowed_virtual_network_subnet_ids = [
    data.azurerm_subnet.fn3cgn.id
  ]

  subnet_id            = null
  private_dns_zone_ids = []

  tags = var.tags

}

## Database
module "cgn_cosmos_db" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.1.7"
  name                = "db"
  resource_group_name = data.azurerm_resource_group.cgn.name
  account_name        = module.cosmos_cgn.name
}


## Blob storage due to legal backup
#tfsec:ignore:azure-storage-default-action-deny
// TODO: verify to use underscore or middlescore
module "cgn_legalbackup_storage" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.79"

  name                       = replace(format("%s_legalbackup_cgn_storage", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.cgn_legalbackup_enable_versioning
  resource_group_name        = data.azurerm_resource_group.cgn.name
  location                   = data.azurerm_resource_group.cgn.location
  advanced_threat_protection = false
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.cgn_legalbackup_delete_retention_days

  tags = var.tags
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_access_key" {
  name         = "cgn-legalbackup-storage-access-key"
  value        = module.cgn_legalbackup_storage.primary_access_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_connection_string" {
  name         = "legalbackup-storage-connection-string"
  value        = module.cgn-legalbackup-storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_blob_connection_string" {
  name         = "legalbackup-storage-blob-connection-string"
  value        = module.cgn-legalbackup-storage.primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_storage_container" "cgn-legalbackup-container" {
  name                  = format("%s-legalbackup-blob", local.project)
  storage_account_name  = module.cgn-legalbackup-storage.name
  container_access_type = "private"
}
