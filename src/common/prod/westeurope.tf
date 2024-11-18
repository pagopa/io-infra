module "event_hubs_weu" {
  source = "../_modules/event_hubs"

  location                  = "westeurope"
  location_short            = local.core.resource_groups.westeurope.location_short
  project                   = local.project_weu_legacy
  resource_group_common     = local.core.resource_groups.westeurope.common
  resource_group_assets_cdn = local.core.resource_groups.westeurope.assets_cdn

  servicebus_dns_zone   = module.global.dns.private_dns_zones.servicebus
  vnet_common           = local.core.networking.weu.vnet_common
  key_vault             = local.core.key_vault.weu.kv
  error_action_group_id = module.monitoring_weu.action_groups.error

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

  location              = "westeurope"
  location_short        = local.core.resource_groups.westeurope.location_short
  project               = local.project_weu_legacy
  resource_group_common = local.core.resource_groups.westeurope.common

  kv_id        = local.core.key_vault.weu.kv.id
  kv_common_id = local.core.key_vault.weu.kv_common.id

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
      name                              = "CIE L2",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL2&entityID=xx_servizicie",
      frequency                         = 900
      http_status                       = 200,
      ssl_cert_remaining_lifetime_check = 1,
    },
    {
      # CIE https://app-backend.io.italia.it/login?authLevel=SpidL3&entityID=xx_servizicie
      name                              = "CIE L3",
      host                              = module.global.dns.public_dns_zones.io_italia_it.app_backend
      path                              = "/login?authLevel=SpidL3&entityID=xx_servizicie",
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

  location                = "westeurope"
  location_short          = local.core.resource_groups.westeurope.location_short
  project                 = local.project_weu_legacy
  prefix                  = local.prefix
  resource_group_external = local.core.resource_groups.westeurope.external
  resource_group_security = local.core.resource_groups.westeurope.sec
  resource_group_common   = local.core.resource_groups.westeurope.common

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  vnet_common      = local.core.networking.weu.vnet_common
  key_vault        = local.core.key_vault.weu.kv
  key_vault_common = local.core.key_vault.weu.kv_common
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
    api_io_selfcare_pagopa_it            = "api-io-selfcare-pagopa-it"
    firmaconio_selfcare_pagopa_it        = "firmaconio-selfcare-pagopa-it"
    continua_io_pagopa_it                = "continua-io-pagopa-it"
    selfcare_io_pagopa_it                = "selfcare-io-pagopa-it"
    oauth_io_pagopa_it                   = "oauth-io-pagopa-it"
    ipatente_io_pagopa_it                = "ipatente-io-pagopa-it"
  }

  cidr_subnet           = ["10.0.13.0/24"]
  min_capacity          = 20 # 4 capacity=baseline, 10 capacity=high volume event, 15 capacity=very high volume event
  max_capacity          = 100
  alerts_enabled        = true
  deny_paths            = ["\\/admin\\/(.*)"]
  error_action_group_id = module.monitoring_weu.action_groups.error

  tags = merge(local.tags, { Source = "https://github.com/pagopa/io-infra" })
}

module "apim_weu" {
  source = "../_modules/apim"

  location                = "westeurope"
  location_short          = local.core.resource_groups.westeurope.location_short
  project                 = local.project_weu_legacy
  prefix                  = local.prefix
  resource_group_common   = local.core.resource_groups.westeurope.common
  resource_group_internal = local.core.resource_groups.westeurope.internal

  vnet_common = local.core.networking.weu.vnet_common
  cidr_subnet = "10.0.100.0/24"

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  key_vault        = local.core.key_vault.weu.kv
  key_vault_common = local.core.key_vault.weu.kv_common

  action_group_id        = module.monitoring_weu.action_groups.error
  ai_instrumentation_key = module.monitoring_weu.appi_instrumentation_key

  tags = local.tags
}

module "assets_cdn_weu" {
  source = "../_modules/assets_cdn"

  location                  = "westeurope"
  location_short            = local.core.resource_groups.westeurope.location_short
  project                   = local.project_weu_legacy
  resource_group_common     = local.core.resource_groups.westeurope.common
  resource_group_assets_cdn = local.core.resource_groups.westeurope.assets_cdn
  resource_group_external   = local.core.resource_groups.westeurope.external

  key_vault_common    = local.core.key_vault.weu.kv_common
  external_domain     = module.global.dns.external_domain
  public_dns_zones    = module.global.dns.public_dns_zones
  dns_default_ttl_sec = module.global.dns.dns_default_ttl_sec
  assets_cdn_fn = {
    name     = data.azurerm_linux_function_app.function_assets_cdn.name
    hostname = data.azurerm_linux_function_app.function_assets_cdn.default_hostname
  }

  tags = local.tags
}

module "cosmos_api_weu" {
  source = "../_modules/cosmos_api"

  location       = "westeurope"
  location_short = local.core.resource_groups.westeurope.location_short
  project        = local.project_weu_legacy

  resource_group_internal        = local.core.resource_groups.westeurope.internal
  vnet_common                    = local.core.networking.weu.vnet_common
  pep_snet                       = local.core.networking.weu.pep_snet
  secondary_location             = "italynorth"
  secondary_location_pep_snet_id = local.core.networking.itn.pep_snet.id
  documents_dns_zone             = module.global.dns.private_dns_zones.documents
  allowed_subnets_ids            = values(data.azurerm_subnet.cosmos_api_allowed)[*].id

  error_action_group_id = module.monitoring_weu.action_groups.error

  tags = local.tags
}

module "redis_weu" {
  source = "../_modules/redis"

  location       = "westeurope"
  location_short = local.core.resource_groups.westeurope.location_short
  project        = local.project_weu_legacy

  resource_group_common    = local.core.resource_groups.westeurope.common
  vnet_common              = local.core.networking.weu.vnet_common
  cidr_subnet_redis_common = "10.0.200.0/24"

  tags = local.tags
}

module "app_backend_weu" {
  for_each = local.app_backends
  source   = "../_modules/app_backend"

  location                = "westeurope"
  location_short          = local.core.resource_groups.westeurope.location_short
  project                 = local.project_weu_legacy
  prefix                  = local.prefix
  resource_group_linux    = local.core.resource_groups.westeurope.linux
  resource_group_internal = local.core.resource_groups.westeurope.internal
  resource_group_common   = local.core.resource_groups.westeurope.common

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  name  = "l${each.key}"
  index = each.key

  vnet_common                = local.core.networking.weu.vnet_common
  cidr_subnet                = each.value.cidr_subnet
  nat_gateways               = local.core.networking.weu.nat_gateways
  allowed_subnets            = concat(data.azurerm_subnet.services_snet.*.id, [module.application_gateway_weu.snet.id, module.apim_weu.snet.id, module.apim_itn.snet.id])
  slot_allowed_subnets       = concat([local.azdoa_snet_id["weu"]], data.azurerm_subnet.services_snet.*.id, [module.application_gateway_weu.snet.id, module.apim_weu.snet.id, module.apim_itn.snet.id])
  allowed_ips                = module.monitoring_weu.appi.reserved_ips
  slot_allowed_ips           = module.monitoring_weu.appi.reserved_ips
  apim_snet_address_prefixes = module.apim_itn.snet.address_prefixes

  backend_hostnames = local.backend_hostnames

  key_vault        = local.core.key_vault.weu.kv
  key_vault_common = local.core.key_vault.weu.kv_common

  error_action_group_id  = module.monitoring_weu.action_groups.error
  application_insights   = module.monitoring_weu.appi
  ai_instrumentation_key = module.monitoring_weu.appi_instrumentation_key

  redis_common = {
    hostname           = module.redis_weu.hostname
    ssl_port           = module.redis_weu.ssl_port
    primary_access_key = module.redis_weu.primary_access_key
  }

  tags = local.tags
}

module "app_backend_li_weu" {
  source = "../_modules/app_backend"

  location                = "westeurope"
  location_short          = local.core.resource_groups.westeurope.location_short
  project                 = local.project_weu_legacy
  prefix                  = local.prefix
  resource_group_linux    = local.core.resource_groups.westeurope.linux
  resource_group_internal = local.core.resource_groups.westeurope.internal
  resource_group_common   = local.core.resource_groups.westeurope.common

  datasources = {
    azurerm_client_config = data.azurerm_client_config.current
  }

  name  = "li"
  is_li = true

  vnet_common  = local.core.networking.weu.vnet_common
  cidr_subnet  = local.app_backendli.cidr_subnet
  nat_gateways = local.core.networking.weu.nat_gateways
  allowed_subnets = concat(data.azurerm_subnet.services_snet.*.id,
    [
      data.azurerm_subnet.admin_snet.id,
      data.azurerm_subnet.itn_auth_fast_login_func_snet.id,
      data.azurerm_subnet.itn_auth_lv_func_snet.id,
      data.azurerm_subnet.itn_msgs_sending_func_snet.id
  ])
  slot_allowed_subnets = concat([local.azdoa_snet_id["weu"]], data.azurerm_subnet.services_snet.*.id, [data.azurerm_subnet.admin_snet.id])
  allowed_ips = concat(module.monitoring_weu.appi.reserved_ips,
    [
      // aks prod01
      "51.105.109.140/32"
  ])
  slot_allowed_ips           = []
  apim_snet_address_prefixes = module.apim_itn.snet.address_prefixes

  backend_hostnames = local.backend_hostnames

  autoscale = {
    default = 10
    minimum = 2
    maximum = 30
  }

  key_vault        = local.core.key_vault.weu.kv
  key_vault_common = local.core.key_vault.weu.kv_common

  error_action_group_id  = module.monitoring_weu.action_groups.error
  application_insights   = module.monitoring_weu.appi
  ai_instrumentation_key = module.monitoring_weu.appi_instrumentation_key

  redis_common = {
    hostname           = module.redis_weu.hostname
    ssl_port           = module.redis_weu.ssl_port
    primary_access_key = module.redis_weu.primary_access_key
  }

  tags = local.tags
}
