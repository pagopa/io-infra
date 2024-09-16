module "app_backend_snet" {
  source                                    = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.27.0"
  name                                      = "appbackend${var.name}"
  address_prefixes                          = var.cidr_subnet
  resource_group_name                       = var.resource_groups.common
  virtual_network_name                      = var.vnet_common.name
  private_endpoint_network_policies_enabled = true

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

resource "azurerm_subnet_nat_gateway_association" "app_backend_snet" {
  nat_gateway_id = var.nat_gateway.id
  subnet_id      = module.app_backend_snet.id
}