
# Redis Common
data "azurerm_redis_cache" "redis_common" {
  name                = format("%s-%s-%s-redis-std-v6", local.product, var.location_short, var.domain)
  resource_group_name = data.azurerm_resource_group.data_rg.name
}
