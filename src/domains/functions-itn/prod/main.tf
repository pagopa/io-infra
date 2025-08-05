module "function-app" {
  source                              = "../_modules/function-app"
  prefix                              = local.prefix
  env_short                           = local.env_short
  function_services_kind              = local.function_services_kind
  function_services_sku_tier          = local.function_services_sku_tier
  function_services_sku_size          = local.function_services_sku_size
  function_services_autoscale_minimum = local.function_services_autoscale_minimum
  function_services_autoscale_maximum = local.function_services_autoscale_maximum
  function_services_autoscale_default = local.function_services_autoscale_default
  vnet_common_name_itn                = local.vnet_common_name_itn
  common_resource_group_name_itn      = local.common_resource_group_name_itn
  project_itn                         = local.project_itn
  services_snet                       = module.networking.services_snet
  tags                                = local.tags
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

import {
  to = module.containers.module.db_subscription_cidrs_container.azurerm_cosmosdb_sql_container.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/subscription-cidrs"
}
