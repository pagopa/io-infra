module "apim_itn" {
  source = "./_modules/apim"

  location                = "italynorth"
  location_short          = local.core.resource_groups.italynorth.location_short
  project                 = local.project_itn
  prefix                  = local.prefix
  resource_group_common   = local.resource_groups.itn.common
  resource_group_internal = local.resource_groups.itn.internal

  use_case = "development"

  vnet_common = data.azurerm_virtual_network.itn_common
  cidr_subnet = "10.20.100.0/24"

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  action_group_id      = local.platform_observability.monitoring_westeurope.action_groups.error
  ai_connection_string = local.platform_observability.monitoring_westeurope.appi_connection_string

  azure_adgroup_wallet_admins_object_id = data.azuread_group.wallet_admins.object_id
  azure_adgroup_com_admins_object_id    = data.azuread_group.com_admins.object_id
  azure_adgroup_svc_admins_object_id    = data.azuread_group.svc_admins.object_id
  azure_adgroup_auth_admins_object_id   = data.azuread_group.auth_admins.object_id
  azure_adgroup_bonus_admins_object_id  = data.azuread_group.bonus_admins.object_id

  tags = local.tags
}