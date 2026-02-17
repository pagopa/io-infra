resource "azurerm_subnet" "platform_api_gateway" {
  name                 = "${var.project}-platform-api-gateway-snet-01"
  resource_group_name  = var.vnet_common.resource_group_name
  virtual_network_name = var.vnet_common.name
  address_prefixes     = [var.cidr_subnet]

  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web"
  ]
}
