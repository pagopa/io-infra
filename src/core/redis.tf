module "redis_common_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.15"
  name                                      = "rediscommon"
  address_prefixes                          = var.cidr_subnet_redis_common
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = false
}

module "redis_common" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v4.1.15"

  name                          = format("%s-redis-common", local.project)
  resource_group_name           = azurerm_resource_group.rg_common.name
  location                      = azurerm_resource_group.rg_common.location
  capacity                      = var.redis_common.capacity
  shard_count                   = var.redis_common.shard_count
  family                        = var.redis_common.family
  sku_name                      = var.redis_common.sku_name
  subnet_id                     = module.redis_common_snet.id
  public_network_access_enabled = var.redis_common.public_network_access_enabled

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
