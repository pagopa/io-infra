resource "azurerm_subnet" "app_gateway" {
  name                 = "${local.project}-appgateway-snet"
  resource_group_name  = data.azurerm_resource_group.weu_common.name
  virtual_network_name = data.azurerm_virtual_network.weu_common.name
  address_prefixes     = ["10.0.13.0/24"]

  private_endpoint_network_policies = "Enabled"

  service_endpoints = [
    "Microsoft.Web",
  ]
}
