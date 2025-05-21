resource "azurerm_subnet" "platform_service_bus_namespace_subnet" {
  name                 = "${var.project}-platform-sbns-snet-01"
  resource_group_name  = var.vnet_common.resource_group_name
  virtual_network_name = var.vnet_common.name
  address_prefixes     = [var.cidr_subnet]

  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web"
  ]
}
