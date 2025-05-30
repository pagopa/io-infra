
/**
* [REDIS V6]
*/
module "redis_spid_login" {
  source                = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v8.56.0"
  name                  = format("%s-redis-std-v6", local.project)
  resource_group_name   = data.azurerm_resource_group.common_rg.name
  location              = data.azurerm_resource_group.common_rg.location
  capacity              = 0
  family                = "C"
  sku_name              = "Standard"
  redis_version         = "6"
  enable_authentication = true
  zones                 = null

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
    subnet_id            = module.redis_spid_login_snet.id
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_redis_cache.id]
  }

  tags = var.tags
}
