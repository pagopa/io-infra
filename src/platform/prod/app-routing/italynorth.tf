resource "dx_available_subnet_cidr" "next_cidr_snet_agw" {
  virtual_network_id = local.core.networking.itn.vnet_common.id
  prefix_length      = 24
}

module "apim_itn" {
  source = "./_modules/apim"

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

  action_group_id      = local.platform_observability.monitoring_westeurope.action_groups.error
  ai_connection_string = local.platform_observability.monitoring_westeurope.appi_connection_string

  azure_adgroup_wallet_admins_object_id = data.azuread_group.wallet_admins.object_id
  azure_adgroup_com_admins_object_id    = data.azuread_group.com_admins.object_id
  azure_adgroup_svc_admins_object_id    = data.azuread_group.svc_admins.object_id
  azure_adgroup_auth_admins_object_id   = data.azuread_group.auth_admins.object_id
  azure_adgroup_bonus_admins_object_id  = data.azuread_group.bonus_admins.object_id

  tags = local.tags
}

module "application_gateway_itn" {
  source = "./_modules/application_gateway"

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
  external_domain  = local.platform_core.dns.zones.external_domain
  public_dns_zones = local.platform_core.dns.zones.public_dns_zones

  backend_hostnames = {
    firmaconio_selfcare_web_app = [data.azurerm_linux_web_app.firmaconio_selfcare_web_app.default_hostname]
    app_backends                = [for appbe in local.platform_app_backend.app_backend.weu : appbe.default_hostname]
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
    continua_ioapp_it                    = "continua-ioapp-it"
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
  error_action_group_id = local.platform_observability.monitoring_westeurope.action_groups.error

  ioweb_kv = {
    name                = data.azurerm_key_vault.ioweb_kv.name
    resource_group_name = data.azurerm_key_vault.ioweb_kv.resource_group_name
  }

  tags = local.tags
}

module "platform_api_gateway_apim_itn" {
  source = "./_modules/platform_api_gateway"

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

  action_group_id = local.platform_observability.monitoring_westeurope.action_groups.error
  application_insights = {
    id                         = local.platform_observability.monitoring_westeurope.appi.id
    connection_string          = local.platform_observability.monitoring_westeurope.appi_connection_string
    log_analytics_workspace_id = local.platform_observability.monitoring_westeurope.log.id
  }

  azure_adgroup_platform_admins_object_id = data.azuread_group.platform_admins.object_id
  azure_adgroup_bonus_admins_object_id    = data.azuread_group.bonus_admins.object_id
  azure_adgroup_auth_admins_object_id     = data.azuread_group.auth_admins.object_id
  azure_adgroup_com_admins_object_id      = data.azuread_group.com_admins.object_id

  azure_user_assigned_identity_auth_infra_cd  = data.azurerm_user_assigned_identity.auth_n_identity_infra_cd.principal_id
  azure_user_assigned_identity_bonus_infra_cd = data.azurerm_user_assigned_identity.bonus_infra_cd.principal_id
  azure_user_assigned_identity_com_infra_cd   = data.azurerm_user_assigned_identity.com_infra_cd.principal_id
  azure_user_assigned_identity_fims_infra_cd  = data.azurerm_user_assigned_identity.fims_infra_cd.principal_id

  app_backend_urls = [for host in local.platform_app_backend.app_backend.weu : "https://${host.default_hostname}"]

  tags = local.tags
}