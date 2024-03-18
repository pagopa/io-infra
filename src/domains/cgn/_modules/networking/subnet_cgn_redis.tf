module "subnet_redis" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.69.1"

  name                 = format("%s-redis-cgn-snet", var.project)
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  address_prefixes                          = var.cidr_subnet_redis
  private_endpoint_network_policies_enabled = false
}
