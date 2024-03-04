module "subnet_private_endpoints" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.64.0"

  name                 = "pendpoints"
  resource_group_name  = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  address_prefixes                          = var.cidr_subnet_pendpoints
  private_endpoint_network_policies_enabled = false
}
