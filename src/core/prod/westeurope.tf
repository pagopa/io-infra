data "azurerm_resource_group" "common_weu" {
  name = format("%s-rg-common", local.project_weu_legacy)
}

module "networking_weu" {
  source = "../_modules/networking"

  location            = data.azurerm_resource_group.common_weu.location
  location_short      = local.location_short[data.azurerm_resource_group.common_weu.location]
  resource_group_name = data.azurerm_resource_group.common_weu.name
  project             = local.project_weu_legacy

  vnet_cidr_block = "10.0.0.0/16"
  pep_snet_cidr   = ["10.0.240.0/23"]

  ng_ips_number = 2

  tags = merge(local.tags, { Source = "https://github.com/pagopa/io-infra" })
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
      use_remote_gateways = false
    }

    beta = {
      name                = data.azurerm_virtual_network.weu_beta.name
      id                  = data.azurerm_virtual_network.weu_beta.id
      resource_group_name = data.azurerm_virtual_network.weu_beta.resource_group_name
      use_remote_gateways = false
      symmetrical = {
        enabled               = true
        use_remote_gateways   = true
        allow_gateway_transit = false
      }
    }

    prod01 = {
      name                = data.azurerm_virtual_network.weu_prod01.name
      id                  = data.azurerm_virtual_network.weu_prod01.id
      resource_group_name = data.azurerm_virtual_network.weu_prod01.resource_group_name
      use_remote_gateways = false
      symmetrical = {
        enabled               = true
        use_remote_gateways   = true
        allow_gateway_transit = false
      }
    }
  }
}

module "container_registry" {
  source = "../_modules/container_registry"

  location       = data.azurerm_resource_group.common_weu.location
  location_short = local.location_short[data.azurerm_resource_group.common_weu.location]
  project        = local.project_weu_legacy

  tags = merge(local.tags, { Source = "https://github.com/pagopa/io-infra" })
}

module "key_vault_weu" {
  source = "../_modules/key_vaults"

  location              = data.azurerm_resource_group.common_weu.location
  location_short        = local.location_short[data.azurerm_resource_group.common_weu.location]
  project               = local.project_weu_legacy
  resource_group_common = data.azurerm_resource_group.common_weu.name
  tenant_id             = data.azurerm_client_config.current.tenant_id

  tags = local.tags
}

module "vpn_weu" {
  source = "../_modules/vpn"

  location            = data.azurerm_resource_group.common_weu.location
  location_short      = local.location_short[data.azurerm_resource_group.common_weu.location]
  resource_group_name = data.azurerm_resource_group.common_weu.name
  project             = local.project_weu_legacy
  prefix              = local.prefix
  env_short           = local.env_short

  subscription_current     = data.azurerm_subscription.current
  vnet_common              = module.networking_weu.vnet_common
  vpn_cidr_subnet          = ["10.0.133.0/24"]
  dnsforwarder_cidr_subnet = ["10.0.252.8/29"]

  tags = local.tags
}

module "event_hubs_weu" {
  source = "../_modules/event_hubs"

  location       = data.azurerm_resource_group.common_weu.location
  location_short = local.location_short[data.azurerm_resource_group.common_weu.location]
  project        = local.project_weu_legacy

  resource_group_common           = data.azurerm_resource_group.common_weu.name
  privatelink_servicebus_dns_zone = module.global.dns.private_dns_zones.privatelink_servicebus
  vnet_common                     = module.networking_weu.vnet_common
  key_vault                       = module.key_vault_weu.kv_common

  cidr_subnet = ["10.0.10.0/24"]
  sku_name    = "Standard"
  eventhubs   = local.eventhubs
  ip_rules = [
    {
      ip_mask = "18.192.147.151", # PDND
      action  = "Allow"
    },
    {
      ip_mask = "18.159.227.69", # PDND
      action  = "Allow"
    },
    {
      ip_mask = "3.126.198.129", # PDND
      action  = "Allow"
    }
  ]

  tags = local.tags
}
