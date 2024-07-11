resource "azurerm_resource_group" "vnet" {
  name     = "${local.project}-common-rg-01"
  location = "italynorth"

  tags = local.tags
}

module "networking_itn" {
  source = "../_modules/networking"

  location            = azurerm_resource_group.vnet.location
  location_short      = local.location_short[azurerm_resource_group.vnet.location]
  resource_group_name = azurerm_resource_group.vnet.name
  project             = local.project

  vnet_cidr_block = "10.20.0.0/16"
  pep_snet_cidr   = ["10.20.2.0/23"]

  tags = local.tags
}