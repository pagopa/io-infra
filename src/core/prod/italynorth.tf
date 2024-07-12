resource "azurerm_resource_group" "vnet" {
  name     = "${local.project_itn}-common-rg-01"
  location = "italynorth"

  tags = local.tags
}

module "networking_itn" {
  source = "../_modules/networking"

  location            = azurerm_resource_group.vnet.location
  location_short      = local.location_short[azurerm_resource_group.vnet.location]
  resource_group_name = azurerm_resource_group.vnet.name
  project             = local.project_itn

  vnet_cidr_block = "10.20.0.0/16"
  pep_snet_cidr   = ["10.20.2.0/23"]

  tags = local.tags
}

module "vnet_peering_itn" {
  source = "../_modules/vnet_peering"

  source_vnet = {
    name                  = module.networking_itn.vnet_common.name
    id                    = module.networking_itn.vnet_common.id
    resource_group_name   = module.networking_itn.vnet_common.resource_group_name
    allow_gateway_transit = true
  }

  target_vnets = {
    weu = {
      name                = module.networking_weu.vnet_common.name
      id                  = module.networking_weu.vnet_common.id
      resource_group_name = module.networking_weu.vnet_common.resource_group_name
      use_remote_gateways = false
    }
    
    beta = {
      name                = data.azurerm_virtual_network.weu_beta.name
      id                  = data.azurerm_virtual_network.weu_beta.id
      resource_group_name = data.azurerm_virtual_network.weu_beta.resource_group_name
      use_remote_gateways = false
    }

    prod01 = {
      name                = data.azurerm_virtual_network.weu_prod01.name
      id                  = data.azurerm_virtual_network.weu_prod01.id
      resource_group_name = data.azurerm_virtual_network.weu_prod01.resource_group_name
      use_remote_gateways = false
    }
  }
}