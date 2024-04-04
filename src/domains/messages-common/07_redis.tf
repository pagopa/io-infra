resource "azurerm_resource_group" "app_messages_common_rg" {
  name     = "${local.product}-app-messages-common-rg"
  location = var.location

  tags = var.tags
}

module "redis_messages" {
  source = "github.com/pagopa/terraform-azurerm-v3//redis_cache?ref=v7.63.0"

  name                = "${local.product}-redis-app-messages-std-v6"
  resource_group_name = azurerm_resource_group.app_messages_common_rg.name
  location            = azurerm_resource_group.app_messages_common_rg.location

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
    subnet_id            = data.azurerm_subnet.private_endpoints_subnet.id
    private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_redis_cache.id]
  }

  tags = var.tags
}
