resource "azurerm_resource_group" "apim" {
  name     = "${local.project}-apim-rg-01"
  location = local.location

  tags = local.tags
}

module "apim_itn" {
  source = "./_modules/apim"

  location              = "italynorth"
  location_short        = local.location_short
  project               = local.project_itn
  prefix                = local.prefix
  resource_group_common = data.azurerm_resource_group.itn_common
  resource_group        = azurerm_resource_group.apim.name

  use_case = "development"

  vnet_common = data.azurerm_virtual_network.itn_common
  cidr_subnet = "10.20.100.0/24"

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  ai_connection_string = data.azurerm_application_insights.itn_ai.connection_string

  azure_adgroup_wallet_admins_object_id = data.azuread_group.wallet_admins.object_id
  azure_adgroup_com_admins_object_id    = data.azuread_group.com_admins.object_id
  azure_adgroup_svc_admins_object_id    = data.azuread_group.svc_admins.object_id
  azure_adgroup_auth_admins_object_id   = data.azuread_group.auth_admins.object_id
  azure_adgroup_bonus_admins_object_id  = data.azuread_group.bonus_admins.object_id

  tags = local.tags
}