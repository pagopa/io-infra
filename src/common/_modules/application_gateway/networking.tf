# Subnet to host the application gateway
module "appgateway_snet" {
  source                                    = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.27.0"
  name                                      = try(local.nonstandard[var.location_short].snet, "${var.project}-agw-snet-01")
  address_prefixes                          = var.cidr_subnet
  resource_group_name                       = var.resource_groups.common
  virtual_network_name                      = var.vnet_common.name
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
  ]
}

## Application gateway public ip ##
resource "azurerm_public_ip" "appgateway_public_ip" {
  name                = try(local.nonstandard[var.location_short].pip, "${var.project}-agw-pip-01")
  resource_group_name = var.resource_groups.external
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = [1, 2, 3]

  tags = var.tags
}