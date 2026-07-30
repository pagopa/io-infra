resource "azurerm_resource_group" "continua_itn_rg" {
  name     = "${local.project_itn}-continua-rg-01"
  location = local.location.italynorth
  tags     = local.tags
}

module "continua_app_service" {
  source = "./_modules/app_service_continua"

  prefix                         = local.prefix
  env_short                      = local.env_short
  location_itn                   = "italynorth"
  project_itn                    = local.project_itn
  project                        = local.project_weu_legacy
  tags                           = local.tags
  vnet_common_name_itn           = local.continua.vnet_common_name_itn
  common_resource_group_name_itn = local.core.resource_groups.italynorth.common
  continua_snet_cidr             = local.continua.cidr_subnet_continua
  continua_resource_group_name   = azurerm_resource_group.continua_itn_rg.name
}