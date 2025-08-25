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

  log_analytics_workspace_id = module.monitoring_weu.log.id

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
  dns_zones   = module.global.dns.private_dns_zones

  tags = local.tags
}

module "apim_itn" {
  source = "../_modules/apim"

  location                = "italynorth"
  location_short          = local.core.resource_groups.italynorth.location_short
  project                 = local.project_itn
  prefix                  = local.prefix
  resource_group_common   = local.resource_groups.itn.common
  resource_group_internal = local.resource_groups.itn.internal

  vnet_common = local.core.networking.itn.vnet_common
  cidr_subnet = "10.20.100.0/24"

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  key_vault        = local.core.key_vault.weu.kv
  key_vault_common = local.core.key_vault.weu.kv_common

  action_group_id      = module.monitoring_weu.action_groups.error
  ai_connection_string = module.monitoring_weu.appi_connection_string

  azure_adgroup_wallet_admins_object_id = data.azuread_group.wallet_admins.object_id
  azure_adgroup_com_admins_object_id    = data.azuread_group.com_admins.object_id
  azure_adgroup_svc_admins_object_id    = data.azuread_group.svc_admins.object_id
  azure_adgroup_auth_admins_object_id   = data.azuread_group.auth_admins.object_id
  azure_adgroup_bonus_admins_object_id  = data.azuread_group.bonus_admins.object_id

  tags = local.tags
}

module "platform_api_gateway_apim_itn" {
  source = "../_modules/platform_api_gateway"

  location                = "italynorth"
  location_short          = local.core.resource_groups.italynorth.location_short
  project                 = local.project_itn
  prefix                  = local.prefix
  resource_group_common   = local.resource_groups.itn.common
  resource_group_internal = local.resource_groups.itn.internal

  vnet_common = local.core.networking.itn.vnet_common
  cidr_subnet = "10.20.101.0/24"

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  key_vault = local.core.key_vault.weu.kv

  action_group_id = module.monitoring_weu.action_groups.error
  application_insights = {
    id                         = module.monitoring_weu.appi.id
    connection_string          = module.monitoring_weu.appi_connection_string
    log_analytics_workspace_id = module.monitoring_weu.log.id
  }

  azure_adgroup_platform_admins_object_id = data.azuread_group.platform_admins.object_id
  azure_adgroup_bonus_admins_object_id    = data.azuread_group.bonus_admins.object_id
  azure_adgroup_auth_admins_object_id     = data.azuread_group.auth_admins.object_id


  azure_user_assigned_identity_auth_infra_cd  = data.azurerm_user_assigned_identity.auth_n_identity_infra_cd.principal_id
  azure_user_assigned_identity_bonus_infra_cd = data.azurerm_user_assigned_identity.bonus_infra_cd.principal_id

  tags = local.tags
}


module "platform_service_bus_namespace_itn" {
  // private DNS zone dependency
  depends_on = [module.global]
  source     = "../_modules/platform_service_bus"

  location = "italynorth"
  project  = local.project_itn
  prefix   = local.prefix

  resource_group_internal = local.resource_groups.itn.internal
  resource_group_event    = local.resource_groups.weu.event
  vnet_common             = local.core.networking.itn.vnet_common
  cidr_subnet             = "10.20.102.0/24"
  pep_snet_id             = local.core.networking.itn.pep_snet.id

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

  tags = local.tags
}

resource "dx_available_subnet_cidr" "next_cidr_snet_agw" {
  virtual_network_id = local.core.networking.itn.vnet_common.id
  prefix_length      = 24
}

module "application_gateway_itn" {
  source = "../_modules/app_gateway"

  location              = "italynorth"
  location_short        = local.core.resource_groups.italynorth.location_short
  project               = local.project_itn
  project_legacy        = local.project_weu_legacy
  prefix                = local.prefix
  resource_group_common = local.core.resource_groups.italynorth.common

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  vnet_common = local.core.networking.itn.vnet_common
  # -- VALUATE IF CREATE A NEW KEY VAULT OR NOT -- #
  key_vault        = local.core.key_vault.weu.kv
  key_vault_common = local.core.key_vault.weu.kv_common
  # ---------------------------------------------- #
  external_domain  = module.global.dns.external_domain
  public_dns_zones = module.global.dns.public_dns_zones

  backend_hostnames = {
    firmaconio_selfcare_web_app = [data.azurerm_linux_web_app.firmaconio_selfcare_web_app.default_hostname]
    app_backends                = [for appbe in module.app_backend_weu : appbe.default_hostname]
  }
  certificates = {
    api                                  = "api-io-pagopa-it"
    api_mtls                             = "api-mtls-io-pagopa-it"
    api_app                              = "api-app-io-pagopa-it"
    api_web                              = "api-web-io-pagopa-it"
    api_io_italia_it                     = "api-io-italia-it"
    app_backend_io_italia_it             = "app-backend-io-italia-it"
    developerportal_backend_io_italia_it = "developerportal-backend-io-italia-it"
    firmaconio_selfcare_pagopa_it        = "firmaconio-selfcare-pagopa-it"
    continua_io_pagopa_it                = "continua-io-pagopa-it"
    selfcare_io_pagopa_it                = "selfcare-io-pagopa-it"
    oauth_io_pagopa_it                   = "oauth-io-pagopa-it"
    vehicles_ipatente_io_pagopa_it       = "vehicles-ipatente-io-pagopa-it"
    licences_ipatente_io_pagopa_it       = "licences-ipatente-io-pagopa-it"
    payments_ipatente_io_pagopa_it       = "payments-ipatente-io-pagopa-it"
    practices_ipatente_io_pagopa_it      = "practices-ipatente-io-pagopa-it"
  }

  cidr_subnet           = [dx_available_subnet_cidr.next_cidr_snet_agw.cidr_block]
  min_capacity          = 7
  max_capacity          = 80
  alerts_enabled        = true
  deny_paths            = ["\\/admin\\/(.*)"]
  error_action_group_id = module.monitoring_weu.action_groups.error

  tags = local.tags
}

module "function_app_services" {
  source                              = "../_modules/function_services/function-app"
  prefix                              = local.prefix
  env_short                           = local.env_short
  function_services_kind              = local.function_services.function_services_kind
  function_services_sku_tier          = local.function_services.function_services_sku_tier
  function_services_sku_size          = local.function_services.function_services_sku_size
  function_services_autoscale_minimum = local.function_services.function_services_autoscale_minimum
  function_services_autoscale_maximum = local.function_services.function_services_autoscale_maximum
  function_services_autoscale_default = local.function_services.function_services_autoscale_default
  vnet_common_name_itn                = local.function_services.vnet_common_name_itn
  common_resource_group_name_itn      = local.function_services.common_resource_group_name_itn
  project_itn                         = local.project_itn
  services_snet_cidr                  = local.function_services.cidr_subnet_services
  tags                                = local.tags
}

module "containers_services" {
  source              = "../_modules/function_services/containers"
  cosmos_db_name      = module.function_app_services.db_name
  resource_group_name = local.resource_groups.weu.internal
  legacy_project      = local.project_weu_legacy
}

import {
  to = module.containers_services.module.db_subscription_cidrs_container.azurerm_cosmosdb_sql_container.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/subscription-cidrs"
}
