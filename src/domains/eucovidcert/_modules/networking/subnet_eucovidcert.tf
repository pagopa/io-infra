module "function_eucovidcert_snet" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.69.1"

  name                 = "${var.project}-eucovidcert-snet"
  address_prefixes     = [var.cidr_subnet_eucovidcert]
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
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

resource "azurerm_subnet_nat_gateway_association" "function_eucovidcert_snet" {
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway.id
  subnet_id      = module.function_eucovidcert_snet.id
}
