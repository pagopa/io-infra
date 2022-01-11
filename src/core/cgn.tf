data "azurerm_resource_group" "cgn" {
  name = format("%s-rg-cgn", local.project)
}

## Database subnet
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