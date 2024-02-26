module "private_endpoints_subnet" {
  source               = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.61.0"

  name                 = "pendpoints"
  address_prefixes     = var.cidr_subnet_pendpoints
  resource_group_name  = var.vnet_resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  private_endpoint_network_policies_enabled = false
}
