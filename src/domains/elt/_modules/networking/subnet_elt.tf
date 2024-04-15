module "function_elt_snet" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.67.1"

  name                 = "fn3eltout"
  address_prefixes     = var.cidr_subnet_elt
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.EventHub",
    "Microsoft.Storage",
    "Microsoft.AzureCosmosDB",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
