### IO-core domain Redis Common
data "azurerm_resource_group" "core_domain_common_rg" {
  name = format("%s-rg-common", local.product)
}

data "azurerm_redis_cache" "core_domain_redis_common" {
  name                = format("%s-redis-common", local.product)
  resource_group_name = data.azurerm_resource_group.core_domain_common_rg.name
}
###
