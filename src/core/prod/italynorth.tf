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
  }
}

module "storage_accounts_itn" {
  source = "../_modules/storage_accounts"

  project             = local.project_itn
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.terraform_weu.name

  azure_adgroup_admin_object_id           = data.azuread_group.admin.object_id
  azure_adgroup_platform_admins_object_id = data.azuread_group.platform_admins.object_id
  azure_adgroup_wallet_admins_object_id   = data.azuread_group.wallet_admins.object_id
  azure_adgroup_wallet_devs_object_id     = data.azuread_group.wallet_devs.object_id
  azure_adgroup_com_admins_object_id      = data.azuread_group.com_admins.object_id
  azure_adgroup_com_devs_object_id        = data.azuread_group.com_devs.object_id
  azure_adgroup_svc_admins_object_id      = data.azuread_group.svc_admins.object_id
  azure_adgroup_svc_devs_object_id        = data.azuread_group.svc_devs.object_id
  azure_adgroup_auth_admins_object_id     = data.azuread_group.auth_admins.object_id
  azure_adgroup_auth_devs_object_id       = data.azuread_group.auth_devs.object_id
  azure_adgroup_bonus_admins_object_id    = data.azuread_group.bonus_admins.object_id
  azure_adgroup_bonus_devs_object_id      = data.azuread_group.bonus_devs.object_id

  messages_sp_object_id = data.azuread_service_principal.platform_iac_sp.object_id

  tags = local.tags
}

module "key_vault_itn" {
  source = "../_modules/key_vault"

  project             = local.project_itn
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.common_itn.name

  tenant_id       = data.azurerm_client_config.current.tenant_id
  subscription_id = data.azurerm_client_config.current.subscription_id

  subnet_pep_id       = module.networking_itn.pep_snet.id
  private_dns_zone_id = data.azurerm_private_dns_zone.key_vault.id

  admins = [
    data.azuread_group.platform_admins.object_id,
    data.azuread_group.wallet_admins.object_id,
    data.azuread_group.com_admins.object_id,
    data.azuread_group.svc_admins.object_id,
  ]

  devs = [
    data.azuread_group.wallet_devs.object_id,
    data.azuread_group.com_devs.object_id,
    data.azuread_group.svc_devs.object_id,
  ]

  tags = local.tags
}
