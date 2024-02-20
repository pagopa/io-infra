module "redis_common_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.61.0"

  name                                      = "rediscommon"
  address_prefixes                          = var.cidr_subnet_redis_common
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = true
}

module "redis_common_backup_zrs" {
  source = "github.com/pagopa/terraform-azurerm-v3//storage_account?ref=v7.61.0"

  name                            = replace(format("%s-stredisbackup", local.project), "-", "")
  account_kind                    = "StorageV2"
  account_tier                    = "Premium"
  access_tier                     = "Hot"
  account_replication_type        = "ZRS"
  resource_group_name             = azurerm_resource_group.rg_common.name
  location                        = azurerm_resource_group.rg_common.location
  advanced_threat_protection      = true
  use_legacy_defender_version     = false
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  tags = var.tags
}

module "redis_common" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v7.61.0"

  name                          = format("%s-redis-common", local.project)
  resource_group_name           = azurerm_resource_group.rg_common.name
  location                      = azurerm_resource_group.rg_common.location
  capacity                      = var.redis_common.capacity
  shard_count                   = var.redis_common.shard_count
  family                        = var.redis_common.family
  sku_name                      = var.redis_common.sku_name
  subnet_id                     = module.redis_common_snet.id
  public_network_access_enabled = var.redis_common.public_network_access_enabled
  redis_version                 = var.redis_common.redis_version
  zones                         = null

  backup_configuration = {
    frequency                 = var.redis_common.rdb_backup_frequency
    max_snapshot_count        = var.redis_common.rdb_backup_max_snapshot_count
    storage_connection_string = module.redis_common_backup_zrs.primary_connection_string
  }

  # when azure can apply patch?
  patch_schedules = [
    {
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

  # only for this redis we use vnet integration (legacy configuration)
  # DO NOT COPY THIS CONFIGURATION FOR NEW REDIS CACHE
  private_endpoint = {
    enabled              = false
    virtual_network_id   = ""
    subnet_id            = ""
    private_dns_zone_ids = [""]
  }

  tags = var.tags
}
