
/**
* [REDIS V6]
*/
resource "azurerm_resource_group" "data_rg_itn" {
  name     = "${local.project_itn}-data-rg-01"
  location = local.itn_location

  tags = var.tags
}

module "redis_common_itn" {
  source                = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v8.44.1"
  name                  = format("%s-redis-std-v6", local.project_itn)
  resource_group_name   = azurerm_resource_group.data_rg_itn.name
  location              = azurerm_resource_group.data_rg_itn.location
  capacity              = 4
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
    virtual_network_id   = data.azurerm_virtual_network.vnet_common_itn.id
    subnet_id            = module.redis_common_snet_itn.id
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_redis_cache.id]
  }

  tags = var.tags
}
