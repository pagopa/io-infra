module "networking_itn" {
  source = "../_modules/networking"

  location            = azurerm_resource_group.common_itn.location
  location_short      = local.location_short[azurerm_resource_group.common_itn.location]
  resource_group_name = azurerm_resource_group.common_itn.name
  project             = local.project_itn

  vnet_cidr_block = "10.20.0.0/16"
  pep_snet_cidr   = ["10.20.2.0/23"]

  ng_number     = 3
  ng_ips_number = 0

  tags = local.tags
}

module "vnet_peering_itn" {
  source = "../_modules/vnet_peering"

  source_vnet = {
    name                  = module.networking_itn.vnet_common.name
    id                    = module.networking_itn.vnet_common.id
    resource_group_name   = module.networking_itn.vnet_common.resource_group_name
    allow_gateway_transit = false
  }

  target_vnets = {
    weu = {
      name                = module.networking_weu.vnet_common.name
      id                  = module.networking_weu.vnet_common.id
      resource_group_name = module.networking_weu.vnet_common.resource_group_name
      use_remote_gateways = true
    }

    prod01 = {
      name                = data.azurerm_virtual_network.weu_prod01.name
      id                  = data.azurerm_virtual_network.weu_prod01.id
      resource_group_name = data.azurerm_virtual_network.weu_prod01.resource_group_name
      use_remote_gateways = false
      symmetrical = {
        enabled = true
      }
    }
  }
}

module "custom_roles" {
  source = "../_modules/custom_roles"

  subscription_id = data.azurerm_subscription.current.id
}
