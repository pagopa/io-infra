data "azurerm_resource_group" "vnet_weu" {
  name = format("%s-rg-common", local.project_weu_legacy)
}

module "networking_weu" {
  source = "../_modules/networking"

  location            = data.azurerm_resource_group.vnet_weu.location
  location_short      = local.location_short[data.azurerm_resource_group.vnet_weu.location]
  resource_group_name = data.azurerm_resource_group.vnet_weu.name
  project             = local.project_weu_legacy

  vnet_cidr_block = "10.0.0.0/16"
  pep_snet_cidr   = ["10.0.240.0/23"]

  ng_ips_number = 2

  tags = local.tags
}

module "dns_weu" {
  source = "../_modules/dns"

  location       = data.azurerm_resource_group.vnet_weu.location
  location_short = local.location_short[data.azurerm_resource_group.vnet_weu.location]
  project        = local.project_weu_legacy

  dns_zone_io = "io"
  vnets = {
    weu = {
      id   = module.networking_weu.vnet_common.id
      name = module.networking_weu.vnet_common.name
    }

    itn = {
      id   = module.networking_itn.vnet_itn.id
      name = module.networking_itn.vnet_itn.name
    }

    beta = {
      id   = data.azurerm_virtual_network.weu_beta.id
      name = data.azurerm_virtual_network.weu_beta.name
    }

    prod_01 = {
      id   = data.azurerm_virtual_network.weu_prod_01.id
      name = data.azurerm_virtual_network.weu_prod_01.name
    }
  }
  tags = local.tags
}
