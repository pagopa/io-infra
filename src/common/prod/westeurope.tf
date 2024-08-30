data "azurerm_resource_group" "common_weu" {
  name = format("%s-rg-common", local.project_weu_legacy)
}

module "event_hubs_weu" {
  source = "../_modules/event_hubs"

  location       = data.azurerm_resource_group.common_weu.location
  location_short = local.location_short[data.azurerm_resource_group.common_weu.location]
  project        = local.project_weu_legacy

  resource_groups       = local.resource_groups
  servicebus_dns_zone   = local.core.global.dns.private_dns_zones.servicebus
  vnet_common           = local.core.networking.weu.vnet_common
  key_vault             = local.core.key_vault.weu.kv
  error_action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  cidr_subnet = ["10.0.10.0/24"]
  sku_name    = "Standard"
  eventhubs   = local.eventhubs
  ip_rules = [
    {
      ip_mask = "18.192.147.151", # PDND
      action  = "Allow"
    },
    {
      ip_mask = "18.159.227.69", # PDND
      action  = "Allow"
    },
    {
      ip_mask = "3.126.198.129", # PDND
      action  = "Allow"
    }
  ]

  tags = local.tags
}

module "monitoring_weu" {
  source = "../_modules/monitoring"

  location              = data.azurerm_resource_group.common_weu.location
  location_short        = local.location_short[data.azurerm_resource_group.common_weu.location]
  project               = local.project_weu_legacy
  resource_group_common = data.azurerm_resource_group.common_weu.name

  kv_id = local.core.key_vault.weu.kv.id

  test_urls = [
    {
      # https://developerportal-backend.io.italia.it/info
      name                              = module.global.dns.public_dns_zones.io_italia_it.developer_portal_backend
      host                              = module.global.dns.public_dns_zones.io_italia_it.developer_portal_backend
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
    },
    {
      # https://api.io.italia.it
      name                              = module.global.dns.public_dns_zones.io_italia_it.api
      host                              = module.global.dns.public_dns_zones.io_italia_it.api
      path                              = "",
      frequency                         = 900
      http_status                       = 404,
      ssl_cert_remaining_lifetime_check = 7,
    },
    {
      # https://app-backend.io.italia.it/info
      name                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
    },
    {
      # https://io.italia.it
      name                              = module.global.dns.public_dns_zones.io_italia_it.name
      host                              = module.global.dns.public_dns_zones.io_italia_it.name
      path                              = "",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
    },
    {
      # https://assets.cdn.io.italia.it/status/backend.json
      name                              = "assets.cdn.io.italia.it",
      host                              = "assets.cdn.io.italia.it",
      path                              = "/status/backend.json",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
    },
    {
      # https://assets.cdn.io.pagopa.it/status/backend.json
      name                              = "assets.cdn.io.pagopa.it",
      host                              = "assets.cdn.io.pagopa.it",
      path                              = "/status/backend.json",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
    },
    {
      # CIE https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=xx_servizicie
      name                              = "CIE",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=xx_servizicie",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
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
    },
    {
      # SpidL2-infocertid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=infocertid
      name                              = "SpidL2-infocertid",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=infocertid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
    },
    {
      # SpidL2-lepidaid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=lepidaid
      name                              = "SpidL2-lepidaid",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=lepidaid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
    },
    {
      # SpidL2-namirialid https://app-backend.io.italia.it/login?authLevel=SpidL2&entityID=namirialid
      name                              = "SpidL2-namirialid",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=namirialid",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
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
    },
    {
      # https://api-app.io.pagopa.it/info
      name                              = module.global.dns.public_dns_zones.io.api_app
      host                              = module.global.dns.public_dns_zones.io.api_app
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
    },
    {
      # https://api-web.io.pagopa.it
      name                              = module.global.dns.public_dns_zones.io.api_web
      host                              = module.global.dns.public_dns_zones.io.api_web
      path                              = "",
      frequency                         = 900
      http_status                       = 404,
      ssl_cert_remaining_lifetime_check = 7,
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
      # https://api.io.selfcare.pagopa.it/info
      name                              = module.global.dns.public_dns_zones.io_selfcare_pagopa_it.api
      host                              = module.global.dns.public_dns_zones.io_selfcare_pagopa_it.api
      path                              = "/info",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
    },
    {
      # https://io.selfcare.pagopa.it
      name                              = "io.selfcare.pagopa.it"
      host                              = "io.selfcare.pagopa.it"
      path                              = "",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
    },
    {
      # https://firmaconio.selfcare.pagopa.it
      name                              = "firmaconio.selfcare.pagopa.it"
      host                              = "firmaconio.selfcare.pagopa.it"
      path                              = "/health",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 7,
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
    },
  ]

  tags = local.tags
}
module "application_gateway_weu" {
  source = "../_modules/application_gateway"

  location       = data.azurerm_resource_group.common_weu.location
  location_short = local.location_short[data.azurerm_resource_group.common_weu.location]
  project        = local.project_weu_legacy
  prefix         = local.prefix

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  resource_groups = local.resource_groups

  vnet_common      = local.core.networking.weu.vnet_common
  key_vault        = local.core.key_vault.weu.kv
  key_vault_common = local.core.key_vault.weu.kv_common
  external_domain  = local.core.global.dns.external_domain
  public_dns_zones = local.core.global.dns.public_dns_zones

  backend_hostnames = {
    firmaconio_selfcare_web_app = data.azurerm_linux_web_app.firmaconio_selfcare_web_app.default_hostname
    app_backendl1               = data.azurerm_linux_web_app.app_backendl1.default_hostname
    app_backendl2               = data.azurerm_linux_web_app.app_backendl2.default_hostname
  }
  certificates = {
    api                                  = "api-io-pagopa-it"
    api_mtls                             = "api-mtls-io-pagopa-it"
    api_app                              = "api-app-io-pagopa-it"
    api_web                              = "api-web-io-pagopa-it"
    api_io_italia_it                     = "api-io-italia-it"
    app_backend_io_italia_it             = "app-backend-io-italia-it"
    developerportal_backend_io_italia_it = "developerportal-backend-io-italia-it"
    api_io_selfcare_pagopa_it            = "api-io-selfcare-pagopa-it"
    firmaconio_selfcare_pagopa_it        = "firmaconio-selfcare-pagopa-it"
    continua_io_pagopa_it                = "continua-io-pagopa-it"
    selfcare_io_pagopa_it                = "selfcare-io-pagopa-it"
    oauth_io_pagopa_it                   = "oauth-io-pagopa-it"
  }

  cidr_subnet           = ["10.0.13.0/24"]
  min_capacity          = 4 # 4 capacity=baseline, 10 capacity=high volume event, 15 capacity=very high volume event
  max_capacity          = 50
  alerts_enabled        = true
  deny_paths            = ["\\/admin\\/(.*)"]
  error_action_group_id = data.azurerm_monitor_action_group.error_action_group.id

  tags = local.tags
}
