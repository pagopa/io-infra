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
  resource_group_common = data.azurerm_resource_group.itn_common.name
  resource_group        = azurerm_resource_group.apim.name

  use_case = "development"

  vnet_common = data.azurerm_virtual_network.itn_common
  cidr_subnet = "10.1.5.0/24"

  key_vault = data.azurerm_key_vault.itn_common

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  ai_connection_string = data.azurerm_application_insights.itn_ai.connection_string

  azure_adgroup_admins_object_id     = data.azuread_group.admins.object_id
  azure_adgroup_developers_object_id = data.azuread_group.developers.object_id
  azure_adgroup_externals_object_id  = data.azuread_group.externals.object_id

  tags = local.tags
}