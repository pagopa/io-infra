# Subnet to host the application gateway
module "appgateway_snet" {
  source                                    = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.27.0"
  name                                      = format("%s-appgateway-snet", var.project)
  address_prefixes                          = var.cidr_subnet_appgateway
  resource_group_name                       = var.resource_group_common
  virtual_network_name                      = var.vnet_common.name
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
  ]
}

## Application gateway public ip ##
resource "azurerm_public_ip" "appgateway_public_ip" {
  name                = format("%s-appgateway-pip", var.project)
  resource_group_name = azurerm_resource_group.rg_external.name
  location            = azurerm_resource_group.rg_external.location
  sku                 = "Standard"
  allocation_method   = "Static"
  zones               = [1, 2, 3]

  tags = var.tags
}