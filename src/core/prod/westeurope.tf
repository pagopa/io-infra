data "azurerm_resource_group" "vnet_weu" {
  name = format("%s-rg-common", local.project_legacy)
}

module "networking_weu" {
  source = "../_modules/networking"

  location            = data.azurerm_resource_group.vnet_weu.location
  location_short      = local.location_short[data.azurerm_resource_group.vnet_weu.location]
  resource_group_name = data.azurerm_resource_group.vnet_weu.name
  project             = local.project_legacy

  vnet_cidr_block = "10.0.0.0/16"
  pep_snet_cidr   = ["10.0.240.0/23"]

  ng_ips_number = 2

  tags = local.tags
}