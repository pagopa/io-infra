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
  azure_adgroup_com_admins_object_id      = data.azuread_group.com_admins.object_id

  azure_user_assigned_identity_auth_infra_cd  = data.azurerm_user_assigned_identity.auth_n_identity_infra_cd.principal_id
  azure_user_assigned_identity_bonus_infra_cd = data.azurerm_user_assigned_identity.bonus_infra_cd.principal_id
  azure_user_assigned_identity_com_infra_cd   = data.azurerm_user_assigned_identity.com_infra_cd.principal_id

  app_backend_urls = [for host in module.app_backend_weu : "https://${host.default_hostname}"]

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

  subscription_id = data.azurerm_subscription.current.subscription_id

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

  cidr_subnet = [dx_available_subnet_cidr.next_cidr_snet_agw.cidr_block]

  # Use "autoscale" mode to enable autoscaling with min_capacity with 7 for low load events, 10 for medium load events, 15 for high load events or use fixed with the desired capacity click day events
  capacity_settings = {
    mode         = "autoscale"
    min_capacity = 20
    max_capacity = 100
  }

  alerts_enabled        = true
  deny_paths            = ["\\/admin\\/(.*)"]
  error_action_group_id = module.monitoring_weu.action_groups.error

  ioweb_kv = {
    name                = data.azurerm_key_vault.ioweb_kv.name
    resource_group_name = data.azurerm_key_vault.ioweb_kv.resource_group_name
  }

  tags = local.tags
}

module "function_app_services" {
  source                              = "../_modules/function_services/function-app"
  prefix                              = local.prefix
  env_short                           = local.env_short
  function_services_autoscale_minimum = local.function_services.function_services_autoscale_minimum
  function_services_autoscale_maximum = local.function_services.function_services_autoscale_maximum
  function_services_autoscale_default = local.function_services.function_services_autoscale_default
  vnet_common_name_itn                = local.function_services.vnet_common_name_itn
  common_resource_group_name_itn      = local.function_services.common_resource_group_name_itn
  project_itn                         = local.project_itn
  services_snet_cidr_old              = local.function_services.cidr_subnet_services_old
  services_snet_cidr                  = local.function_services.cidr_subnet_services
  tags                                = local.tags
}

module "containers_services" {
  source              = "../_modules/function_services/containers"
  cosmos_db_name      = module.function_app_services.db_name
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
  resource_group_name             = local.function_elt.resource_group_name
  vnet_common_name_itn            = local.function_elt.vnet_common_name_itn
  common_resource_group_name_itn  = local.function_elt.common_resource_group_name_itn
  elt_snet_cidr                   = local.function_elt.elt_snet_cidr
  tags                            = local.function_elt.tags
}

module "monitoring_itn" {
  source = "../_modules/monitoring"

  location              = "italynorth"
  location_short        = local.location_short.italynorth
  project               = local.project_itn
  resource_group_common = local.resource_groups.itn.common

  kv_id        = local.core.key_vault.weu.io_p_itn_platform_kv_01.id # Location into the KV module output should be updated to itn (at the moment is weu) after the migration to ITN is completed
  kv_common_id = local.core.key_vault.weu.io_p_itn_platform_kv_01.id # We are going to have only one platform KV containing every secret

  test_urls = [
    {
      # https://developerportal-backend.io.italia.it/info
      name                              = module.global.dns.public_dns_zones.io_italia_it.developer_portal_backend
      host                              = module.global.dns.public_dns_zones.io_italia_it.developer_portal_backend
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://api.io.italia.it
      name                              = module.global.dns.public_dns_zones.io_italia_it.api
      host                              = module.global.dns.public_dns_zones.io_italia_it.api
      path                              = "",
      frequency                         = 900
      http_status                       = 404,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://app-backend.io.italia.it/info
      name                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://io.italia.it
      name                              = module.global.dns.public_dns_zones.io_italia_it.name
      host                              = module.global.dns.public_dns_zones.io_italia_it.name
      path                              = "",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://assets.cdn.io.pagopa.it/status/backend.json
      name                              = "assets.cdn.io.pagopa.it",
      host                              = "assets.cdn.io.pagopa.it",
      path                              = "/status/backend.json",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # CIE https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=xx_servizicie
      name                              = "CIE L2",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=xx_servizicie",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # CIE https://app-backend.io.italia.it/login?authLevel=SpidL3&entityID=xx_servizicie
      name                              = "CIE L3",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL3&entityID=xx_servizicie",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      name                              = "Spid-registry",
      host                              = "registry.spid.gov.it",
      path                              = "/metadata/idp/spid-entities-idps.xml",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # SpidL2-arubaid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=arubaid
      name                              = "SpidL2-arubaid",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=arubaid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # SpidL2-infocertid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=infocertid
      name                              = "SpidL2-infocertid",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=infocertid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # SpidL2-lepidaid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=lepidaid
      name                              = "SpidL2-lepidaid",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=lepidaid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # SpidL2-namirialid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=namirialid
      name                              = "SpidL2-namirialid",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=namirialid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # SpidL2-posteid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=posteid
      name                              = "SpidL2-posteid",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=posteid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # SpidL2-sielteid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=sielteid
      name                              = "SpidL2-sielteid",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=sielteid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # SpidL2-spiditalia https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=spiditalia
      name                              = "SpidL2-spiditalia",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=spiditalia",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # SpidL2-infocamere https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=infocamereid
      name                              = "SpidL2-infocamere",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=infocamereid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
      enabled                           = false
    },
    {
      # https://api.io.pagopa.it
      name                              = module.global.dns.public_dns_zones.io.api
      host                              = module.global.dns.public_dns_zones.io.api
      path                              = "",
      frequency                         = 900
      http_status                       = 404,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://api-app.io.pagopa.it/info
      name                              = module.global.dns.public_dns_zones.io.api_app
      host                              = module.global.dns.public_dns_zones.io.api_app
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://api-web.io.pagopa.it
      name                              = module.global.dns.public_dns_zones.io.api_web
      host                              = module.global.dns.public_dns_zones.io.api_web
      path                              = "",
      frequency                         = 900
      http_status                       = 404,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://api-mtls.io.pagopa.it
      name                              = module.global.dns.public_dns_zones.io.api_mtls
      host                              = module.global.dns.public_dns_zones.io.api_mtls
      path                              = "",
      frequency                         = 900
      http_status                       = 400,
      ssl_cert_remaining_lifetime_check = 0,
      ssl_enabled                       = false
    },
    {
      # https://firmaconio.selfcare.pagopa.it
      name                              = "firmaconio.selfcare.pagopa.it"
      host                              = "firmaconio.selfcare.pagopa.it"
      path                              = "/health",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://raw.githubusercontent.com/pagopa/io-services-metadata/master/status/backend.json
      name                              = "github-raw-status-backend",
      host                              = "raw.githubusercontent.com",
      path                              = "/pagopa/io-services-metadata/master/status/backend.json",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
    {
      # https://continua.io.pagopa.it
      name                              = module.global.dns.public_dns_zones.io.continua
      host                              = module.global.dns.public_dns_zones.io.continua
      path                              = "",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
      enabled                           = false
    },
  ]

  tags = local.tags
}

module "function_assets_cdn_itn" {
  source                         = "../_modules/function_assets_cdn"
  prefix                         = local.prefix
  env_short                      = local.env_short
  project_weu_legacy             = local.project_weu_legacy
  project_itn                    = local.project_itn
  vnet_common_name_itn           = local.function_assets_cdn.vnet_common_name_itn
  common_resource_group_name_itn = local.function_assets_cdn.common_resource_group_name_itn
  assets_cdn_snet_cidr           = local.function_assets_cdn.assets_cdn_snet_cidr
  tags                           = local.tags
}

module "assets_locales_cdn" {
  source = "../_modules/assets_locales_cdn"

  location                  = "italynorth"
  location_short            = local.core.resource_groups.italynorth.location_short
  project                   = local.project_itn
  subscription_id           = data.azurerm_subscription.current.subscription_id
  resource_group_common     = local.core.resource_groups.italynorth.common
  resource_group_assets_cdn = local.core.resource_groups.italynorth.assets_cdn
  resource_group_external   = local.core.resource_groups.italynorth.external

  external_domain                  = module.global.dns.external_domain
  public_dns_zones                 = module.global.dns.public_dns_zones
  dns_default_ttl_sec              = module.global.dns.dns_default_ttl_sec
  azure_adgroup_svc_devs_object_id = data.azuread_group.svc_devs.object_id

  tags = local.tags
}
