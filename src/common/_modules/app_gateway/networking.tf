# Subnet to host the application gateway
resource "azurerm_subnet" "agw" {
  name                              = "${var.project}-agw-snet-01"
  resource_group_name               = var.resource_group_common
  virtual_network_name              = var.vnet_common.name
  address_prefixes                  = var.cidr_subnet
  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web",
  ]
}

## Application gateway public ip ##
resource "azurerm_public_ip" "agw" {
  name                = "${var.project}-agw-pip-01"
  resource_group_name = var.resource_group_common
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = [1, 2, 3]

  tags = var.tags
}
