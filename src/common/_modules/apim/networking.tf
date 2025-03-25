resource "azurerm_subnet" "apim" {
  name                 = "${var.project}-apim-snet-01"
  resource_group_name  = var.vnet_common.resource_group_name
  virtual_network_name = var.vnet_common.name
  address_prefixes     = [var.cidr_subnet]

  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web",
  ]
}

resource "azurerm_public_ip" "apim" {
  name                = "${var.project}-apim-pip-01"
  resource_group_name = var.resource_group_common
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "apimio"
  zones               = ["1", "2", "3"]

  tags = var.tags
}