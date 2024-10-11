# Citizen-auth domain Redis Common
data "azurerm_redis_cache" "redis_common_itn" {
  name                = format("%s-redis-std-v6", local.project_itn)
  resource_group_name = data.azurerm_resource_group.data_rg_itn.name
}

### IO-core domain Redis Common
data "azurerm_resource_group" "core_domain_common_rg" {
  name = format("%s-rg-common", local.product)
}

data "azurerm_redis_cache" "core_domain_redis_common" {
  name                = format("%s-redis-common", local.product)
  resource_group_name = data.azurerm_resource_group.core_domain_common_rg.name
}
###
