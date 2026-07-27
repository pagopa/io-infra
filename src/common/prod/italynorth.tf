resource "azurerm_resource_group" "github_runner" {
  name     = "${local.project_itn}-github-runner-rg-01"
  location = "italynorth"

  tags = local.tags
}

module "github_runner_itn" {
  source = "../_modules/github_runner"

  prefix              = local.prefix
  env_short           = local.env_short
  project             = local.project_itn
  location            = "italynorth"
  resource_group_name = azurerm_resource_group.github_runner.name

  vnet_common = local.core.networking.itn.vnet_common

  cidr_subnet = "10.20.14.0/23"

  log_analytics_workspace_id = local.platform_observability.monitoring_westeurope.log.id

  key_vault_pat_token = {
    name                = local.core.key_vault.weu.kv_common.name
    resource_group_name = local.core.key_vault.weu.kv_common.resource_group_name
  }

  tags = local.tags
}

module "private_endpoints" {
  source = "../_modules/private_endpoint"

  project             = local.project_itn
  location            = "italynorth"
  resource_group_name = local.resource_groups.itn.common

  pep_snet_id = local.core.networking.itn.pep_snet.id
  dns_zones   = local.platform_core.dns.zones.private_dns_zones

  tags = local.tags
}

module "storage_accounts_itn" {
  source = "../_modules/storage_accounts"

  location                  = "italynorth"
  project                   = local.project_itn
  subscription_id           = data.azurerm_subscription.current.subscription_id
  resource_group_common     = local.core.resource_groups.italynorth.common
  resource_group_operations = local.core.resource_groups.westeurope.operations

  azure_adgroup_com_admins_object_id = data.azuread_group.com_admins.object_id
  azure_adgroup_com_devs_object_id   = data.azuread_group.com_devs.object_id
  azure_adgroup_admins_object_id     = data.azuread_group.admins.object_id
  azure_adgroup_svc_devs_object_id   = data.azuread_group.svc_devs.object_id

  tags = local.tags
}

module "function_app_services_02" {
  source                              = "../_modules/function_services/function-app"
  prefix                              = local.prefix
  env_short                           = local.env_short
  function_services_autoscale_minimum = local.function_services.function_services_autoscale_minimum
  function_services_autoscale_maximum = local.function_services.function_services_autoscale_maximum
  function_services_autoscale_default = local.function_services.function_services_autoscale_default
  sku_size                            = "P1v3"
  vnet_common_name_itn                = local.function_services.vnet_common_name_itn
  instance_number                     = "02"
  common_resource_group_name_itn      = local.function_services.common_resource_group_name_itn
  project_itn                         = local.project_itn
  services_snet_cidr                  = local.function_services.cidr_subnet_services_02
  tags                                = local.tags
}

module "containers_services" {
  source              = "../_modules/function_services/containers"
  cosmos_db_name      = module.function_app_services_02.db_name
  resource_group_name = local.resource_groups.weu.internal
  legacy_project      = local.project_weu_legacy
}

module "continua_app_service" {
  source = "../_modules/app_continua"

  prefix                         = local.prefix
  env_short                      = local.env_short
  location_itn                   = "italynorth"
  project_itn                    = local.project_itn
  project                        = local.project_weu_legacy
  tags                           = local.tags
  vnet_common_name_itn           = local.continua.vnet_common_name_itn
  common_resource_group_name_itn = local.resource_groups.itn.common
  continua_snet_cidr             = local.continua.cidr_subnet_continua
}

module "function_app_admin" {
  source                         = "../_modules/function_admin"
  prefix                         = local.prefix
  env_short                      = local.env_short
  vnet_common_name_itn           = local.function_admin.vnet_common_name_itn
  common_resource_group_name_itn = local.function_admin.common_resource_group_name_itn
  project_itn                    = local.project_itn
  admin_snet_cidr                = local.function_admin.cidr_subnet_admin
  tags                           = local.tags
}

module "function_app_elt" {
  source                          = "../_modules/function_elt"
  prefix                          = local.prefix
  env_short                       = local.env_short
  project_weu_legacy              = local.project_weu_legacy
  secondary_location_display_name = local.function_elt.secondary_location_display_name
  location_itn                    = local.function_elt.location_itn
  vnet_common_name_itn            = local.function_elt.vnet_common_name_itn
  common_resource_group_name_itn  = local.function_elt.common_resource_group_name_itn
  elt_snet_cidr                   = local.function_elt.elt_snet_cidr
  tags                            = local.function_elt.tags
}

module "assets_locales_cdn" {
  source = "../_modules/assets_locales_cdn"

  location                = "italynorth"
  project                 = local.project_itn
  subscription_id         = data.azurerm_subscription.current.subscription_id
  resource_group_common   = local.core.resource_groups.italynorth.common
  resource_group_cdn      = local.core.resource_groups.italynorth.assets_cdn
  resource_group_external = "io-p-rg-external"

  public_dns_zones                       = local.platform_core.dns.zones.public_dns_zones
  log_analytics_workspace_id             = local.platform_observability.monitoring_italynorth.log.id
  diagnostic_settings_storage_account_id = module.storage_accounts_itn.logs_itn.id

  azure_adgroups_roles = {
    svc_devs = {
      azureadgroup_id = data.azuread_group.svc_devs.object_id
      role            = "writer"
    }
  }

  tags = local.tags
}
