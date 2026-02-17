module "networking_weu" {
  source = "../_modules/networking"

  location            = azurerm_resource_group.common_weu.location
  location_short      = local.location_short[azurerm_resource_group.common_weu.location]
  resource_group_name = azurerm_resource_group.common_weu.name
  project             = local.project_weu_legacy

  vnet_cidr_block = "10.0.0.0/16"
  pep_snet_cidr   = ["10.0.240.0/23"]

  ng_ips_number    = 2
  ng_ippres_number = 0

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
      use_remote_gateways = false
    }
  }
}

module "key_vault_weu" {
  source = "../_modules/key_vaults"

  location              = azurerm_resource_group.common_weu.location
  location_short        = local.location_short[azurerm_resource_group.common_weu.location]
  project               = local.project_weu_legacy
  resource_group_name   = azurerm_resource_group.sec_weu.name
  resource_group_common = azurerm_resource_group.common_weu.name
  resource_group_itn    = azurerm_resource_group.common_itn.name

  tenant_id       = data.azurerm_client_config.current.tenant_id
  subscription_id = data.azurerm_client_config.current.subscription_id

  subnet_pep_id       = module.networking_itn.pep_snet.id
  private_dns_zone_id = data.azurerm_private_dns_zone.key_vault.id

  admins = [
    data.azuread_group.admin.object_id,
    data.azuread_group.platform_admins.object_id,
    data.azuread_group.wallet_admins.object_id,
    data.azuread_group.com_admins.object_id,
    data.azuread_group.svc_admins.object_id,
    data.azuread_group.auth_admins.object_id,
    data.azuread_group.bonus_admins.object_id
  ]

  devs = [
    data.azuread_group.wallet_devs.object_id,
    data.azuread_group.com_devs.object_id,
    data.azuread_group.svc_devs.object_id,
    data.azuread_group.auth_devs.object_id,
    data.azuread_group.bonus_devs.object_id
  ]

  ci = [
    data.azurerm_user_assigned_identity.managed_identity_io_infra_ci.principal_id
  ]

  cd = [
    data.azurerm_user_assigned_identity.managed_identity_io_infra_cd.principal_id
  ]

  platform_iac_sp_object_id = data.azuread_service_principal.platform_iac_sp.object_id

  tags = local.tags
}

module "vpn_weu" {
  source = "../_modules/vpn"

  location            = azurerm_resource_group.common_weu.location
  location_short      = local.location_short[azurerm_resource_group.common_weu.location]
  resource_group_name = azurerm_resource_group.common_weu.name
  project             = local.project_weu_legacy
  prefix              = local.prefix
  env_short           = local.env_short

  subscription_current     = data.azurerm_subscription.current
  vnet_common              = module.networking_weu.vnet_common
  vpn_cidr_subnet          = ["10.0.133.0/24"]
  dnsforwarder_cidr_subnet = ["10.0.252.8/29"]

  tags = local.tags
}

module "azdoa_weu" {
  source = "../_modules/azure_devops_agent"

  location            = azurerm_resource_group.common_weu.location
  location_short      = local.location_short[azurerm_resource_group.common_weu.location]
  resource_group_name = azurerm_resource_group.common_weu.name
  project             = local.project_weu_legacy

  vnet_common     = module.networking_weu.vnet_common
  resource_groups = local.resource_groups[local.location_short[azurerm_resource_group.common_weu.location]]
  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  cidr_subnet = ["10.0.250.0/24"]

  tags = local.tags
}
