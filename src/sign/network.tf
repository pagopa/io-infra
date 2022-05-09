data "azurerm_virtual_network" "vnet_common" {
  name                = "io-p-vnet-common"
  resource_group_name = "io-p-rg-common"
}

module "io_sign_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.13.1"
  name                 = "${local.project}-snet"
  resource_group_name  = azurerm_resource_group.backend_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  address_prefixes     = ["10.0.102.0/24"]

  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Web", "Microsoft.AzureCosmosDB"]
}