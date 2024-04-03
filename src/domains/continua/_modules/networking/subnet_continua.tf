module "continua_common_snet" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.67.1"

  name                 = format("%s-continua-common-snet", var.project)
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = var.cidr_subnet_continua

  private_endpoint_network_policies_enabled = false
  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
