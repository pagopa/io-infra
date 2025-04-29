resource "azurerm_subnet" "io_proxy" {
  name                 = "${var.project}-io-proxy-snet-01"
  resource_group_name  = var.vnet_common.resource_group_name
  virtual_network_name = var.vnet_common.name
  address_prefixes     = [var.cidr_subnet]

  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web",
  ]
}