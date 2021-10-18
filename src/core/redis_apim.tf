## Database subnet
module "redis_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  count                = var.redis_sku_name == "Premium" && length(var.cidr_subnet_redis) > 0 ? 1 : 0
  name                 = format("%s-redis-apim-snet", local.project)
  address_prefixes     = var.cidr_subnet_redis
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
}

module "redis" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v1.0.37"
  name                  = format("%s-redis-apim", local.project)
  resource_group_name   = data.azurerm_resource_group.vnet_common_rg.name
  location              = data.azurerm_resource_group.vnet_common_rg.location
  capacity              = var.redis_capacity
  family                = var.redis_family
  sku_name              = var.redis_sku_name
  enable_non_ssl_port   = false
  enable_authentication = true
  subnet_id             = length(module.redis_snet.*.id) == 0 ? null : module.redis_snet[0].id
  tags                  = var.tags
}
