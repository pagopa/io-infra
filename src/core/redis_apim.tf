## Database subnet
module "redis_apim_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  count                = var.redis_apim_sku_name == "Premium" && length(var.cidr_subnet_redis_apim) > 0 ? 1 : 0
  name                 = format("%s-redis-apim-snet", local.project)
  address_prefixes     = var.cidr_subnet_redis_apim
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
}

module "redis_apim" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v1.0.37"
  name                  = format("%s-redis-apim", local.project)
  resource_group_name   = azurerm_resource_group.rg_internal.name
  location              = azurerm_resource_group.rg_internal.location
  capacity              = var.redis_apim_capacity
  family                = var.redis_apim_family
  sku_name              = var.redis_apim_sku_name
  enable_non_ssl_port   = false
  enable_authentication = true
  subnet_id             = length(module.redis_apim_snet.*.id) == 0 ? null : module.redis_apim_snet[0].id

  tags = var.tags
}
