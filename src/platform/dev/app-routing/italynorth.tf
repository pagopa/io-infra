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
  cidr_subnet = "10.0.1.0/24"

  key_vault = data.azurerm_key_vault.itn_common

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  ai_connection_string = data.azurerm_application_insights.itn_ai.connection_string

  azure_adgroup_admins_object_id     = "c24cd097-4bff-4ab2-9b53-62b249d722c5" # TODO: change to exported attribute after resource import
  azure_adgroup_developers_object_id = "e0192f80-ef72-4e33-8000-43785bdba187" # TODO: change to exported attribute after resource import
  azure_adgroup_externals_object_id  = "899419b0-8bc3-4321-a9b4-9f309b13842e" # TODO: change to exported attribute after resource import

  tags = local.tags
}