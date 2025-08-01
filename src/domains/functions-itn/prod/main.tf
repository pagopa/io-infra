module "function-app" {
  source                              = "../_modules/function-app"
  prefix                              = local.prefix
  env_short                           = local.env_short
  cidr_subnet_services                = local.cidr_subnet_services
  function_services_kind              = local.function_services_kind
  function_services_sku_tier          = local.function_services_sku_tier
  function_services_sku_size          = local.function_services_sku_size
  function_services_autoscale_minimum = local.function_services_autoscale_minimum
  function_services_autoscale_maximum = local.function_services_autoscale_maximum
  function_services_autoscale_default = local.function_services_autoscale_default
  vnet_common_name_itn                = local.vnet_common_name_itn
  common_resource_group_name_itn      = local.common_resource_group_name_itn
  project_itn                         = local.project_itn
  service_subnet = {
    id   = module.networking.services_snet.id # TODO check if correct i think it needs an array
    name = module.networking.services_snet.name
  }
}

module "networking" {
  source                         = "../_modules/networking"
  vnet_common_name_itn           = local.vnet_common_name_itn
  common_resource_group_name_itn = local.common_resource_group_name_itn
  project_itn                    = local.project_itn
  cidr_subnet_services           = local.cidr_subnet_services
}

module "containers" {
  source         = "../_modules/containers"
  cosmos_db_name = module.function-app.db_name
  project        = local.project
}
