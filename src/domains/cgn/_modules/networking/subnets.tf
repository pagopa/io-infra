module "private_endpoints_subnet" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.61.0"

  name                 = "pendpoints"
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  address_prefixes                          = var.cidr_subnet_pendpoints
  private_endpoint_network_policies_enabled = false
}

module "redis_cgn_snet" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.61.0"

  name                                      = format("%s-redis-cgn-snet", local.project)
  address_prefixes                          = var.cidr_subnet_redis
  resource_group_name                       = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet_common.name
  private_endpoint_network_policies_enabled = false
}

module "cgn_snet" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.61.0"

  name                                      = format("%s-cgn-snet", local.project)
  address_prefixes                          = var.cidr_subnet_cgn
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_nat_gateway_association" "cgn_snet" {
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway.id
  subnet_id      = module.cgn_snet.id
}
