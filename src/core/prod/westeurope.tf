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

module "vnet_peering_weu" {
  source = "../_modules/vnet_peering"

  source_vnet = {
    name                  = module.networking_weu.vnet_common.name
    id                    = module.networking_weu.vnet_common.id
    resource_group_name   = module.networking_weu.vnet_common.resource_group_name
    allow_gateway_transit = true
  }

  target_vnets = {
    itn = {
      name                = module.networking_itn.vnet_common.name
      id                  = module.networking_itn.vnet_common.id
      resource_group_name = module.networking_itn.vnet_common.resource_group_name
      use_remote_gateways = true
    }

    beta = {
      name                = data.azurerm_virtual_network.weu_beta.name
      id                  = data.azurerm_virtual_network.weu_beta.id
      resource_group_name = data.azurerm_virtual_network.weu_beta.resource_group_name
      use_remote_gateways = true
    }

    prod01 = {
      name                = data.azurerm_virtual_network.weu_prod01.name
      id                  = data.azurerm_virtual_network.weu_prod01.id
      resource_group_name = data.azurerm_virtual_network.weu_prod01.resource_group_name
      use_remote_gateways = true
    }
  }
}

module "dns_weu" {
  source = "../_modules/dns"

  location       = data.azurerm_resource_group.vnet_weu.location
  location_short = local.location_short[data.azurerm_resource_group.vnet_weu.location]
  project        = local.project_weu_legacy

  dns_zones = {
    io                  = "io"
    io_selfcare         = "io.selfcare"
    firmaconio_selfcare = "firmaconio.selfcare"
  }

  vnets = {
    weu = {
      id   = module.networking_weu.vnet_common.id
      name = module.networking_weu.vnet_common.name
    }

    itn = {
      id   = module.networking_itn.vnet_common.id
      name = module.networking_itn.vnet_common.name
    }

    beta = {
      id   = data.azurerm_virtual_network.weu_beta.id
      name = data.azurerm_virtual_network.weu_beta.name
    }

    prod01 = {
      id   = data.azurerm_virtual_network.weu_prod01.id
      name = data.azurerm_virtual_network.weu_prod01.name
    }
  }

  # TODO: substitute with actual resource names when resource_groups module is implemented
  resource_groups = {
    common   = "${local.project_weu_legacy}-rg-common"
    internal = "${local.project_weu_legacy}-rg-internal"
    external = "${local.project_weu_legacy}-rg-external"
    event    = "${local.project_weu_legacy}-evt-rg"
  }

  # TODO: remove when app gateway module is implemented
  app_gateway_public_ip = data.azurerm_public_ip.appgateway_public_ip.ip_address

  # TODO: remove when apim v2 module is implemented
  apim_v2_public_ip = data.azurerm_api_management.apim_v2.public_ip_addresses[0]

  tags = local.tags
}
