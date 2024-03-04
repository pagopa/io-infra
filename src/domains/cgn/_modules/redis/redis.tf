module "redis_cgn" {
  source              = "github.com/pagopa/terraform-azurerm-v3//redis_cache?ref=v7.63.0"
  name                = format("%s-redis-cgn-std", local.project)
  resource_group_name = var.resource_group_name
  location            = var.location

  capacity              = 1
  family                = "C"
  sku_name              = "Standard"
  enable_authentication = true
  zones                 = null
  redis_version         = "6"

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
    subnet_id            = var.subnet_redis_id
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_redis_cache.id]
  }

  tags = var.tags
}
