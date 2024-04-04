module "snet_selfcare_be_common" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.69.1"

  name                 = "${var.project}-selfcare-be-common-snet"
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  address_prefixes = [var.cidr_subnet_selfcare_be]

  private_endpoint_network_policies_enabled = false
  service_endpoints = [
    "Microsoft.Web",
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
