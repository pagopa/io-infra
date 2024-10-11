resource "azurerm_subnet" "snet" {
  name                              = try(local.nonstandard[var.location_short].snet, "${var.project}-appbe-${var.name}-snet-01")
  address_prefixes                  = var.cidr_subnet
  resource_group_name               = var.resource_group_common
  virtual_network_name              = var.vnet_common.name
  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation {
    name = "default"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_nat_gateway_association" "snet" {
  for_each       = { for ng in var.nat_gateways : ng.id => ng }
  nat_gateway_id = each.key
  subnet_id      = azurerm_subnet.snet.id
}
