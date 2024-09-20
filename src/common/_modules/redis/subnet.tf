resource "azurerm_subnet" "redis" {
  name                              = try(local.nonstandard[var.location_short].subnet, "${var.project}-redis-snet-01")
  address_prefixes                  = [var.cidr_subnet_redis_common]
  resource_group_name               = var.vnet_common.resource_group_name
  virtual_network_name              = var.vnet_common.name
  private_endpoint_network_policies = "Enabled"
}
