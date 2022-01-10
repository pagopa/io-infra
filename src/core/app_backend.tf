### Common resources

locals {
  app_backend = {

    app_settings_common = {
      # No downtime on slots swap
      WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = 1
      WEBSITE_RUN_FROM_PACKAGE                        = "1"
      WEBSITE_VNET_ROUTE_ALL                          = "1"
      WEBSITE_DNS_SERVER                              = "168.63.129.16"

      APPINSIGHTS_INSTRUMENTATIONKEY        = data.azurerm_application_insights.application_insights.instrumentation_key
      APPLICATIONINSIGHTS_CONNECTION_STRING = data.azurerm_application_insights.application_insights.connection_string

      // ENVIRONMENT
      NODE_ENV = "production"

      FETCH_KEEPALIVE_ENABLED = "true"
      // see https://github.com/MicrosoftDocs/azure-docs/issues/29600#issuecomment-607990556
      // and https://docs.microsoft.com/it-it/azure/app-service/app-service-web-nodejs-best-practices-and-troubleshoot-guide#scenarios-and-recommendationstroubleshooting
      // FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL should not exceed 120000 (app service socket timeout)
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL = "110000"
      // (FETCH_KEEPALIVE_MAX_SOCKETS * number_of_node_processes) should not exceed 160 (max sockets per VM)
      FETCH_KEEPALIVE_MAX_SOCKETS         = "128"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      // SPID
      SAML_CALLBACK_URL                      = "https://app-backend.io.italia.it/assertionConsumerService"
      SAML_CERT                              = data.azurerm_key_vault_secret.app_backend_SAML_CERT.value
      SAML_KEY                               = data.azurerm_key_vault_secret.app_backend_SAML_KEY.value
      SAML_LOGOUT_CALLBACK_URL               = "https://app-backend.io.italia.it/slo"
      SAML_ISSUER                            = "https://app-backend.io.italia.it"
      SAML_ATTRIBUTE_CONSUMING_SERVICE_INDEX = "0"
      SAML_ACCEPTED_CLOCK_SKEW_MS            = "2000"
      IDP_METADATA_URL                       = "https://registry.SPID.gov.it/metadata/idp/spid-entities-idps.xml"
      IDP_METADATA_REFRESH_INTERVAL_SECONDS  = "864000" # 10 days

      // CIE
      CIE_METADATA_URL = "https://idserver.servizicie.interno.gov.it:443/idp/shibboleth"

      // AUTHENTICATION
      AUTHENTICATION_BASE_PATH  = ""
      TOKEN_DURATION_IN_SECONDS = "2592000"

      // FUNCTIONS
      API_KEY                     = data.azurerm_key_vault_secret.app_backend_API_KEY.value
      BONUS_API_URL               = "http://${data.azurerm_function_app.fnapp_bonus.default_hostname}/api/v1"
      BONUS_API_KEY               = data.azurerm_key_vault_secret.app_backend_BONUS_API_KEY.value
      CGN_API_URL                 = "http://${data.azurerm_function_app.fnapp_cgn.default_hostname}"
      CGN_API_KEY                 = data.azurerm_key_vault_secret.app_backend_CGN_API_KEY.value
      CGN_OPERATOR_SEARCH_API_URL = "https://cgnonboardingportal-p-os.azurewebsites.net" # prod-esercenti subscription
      CGN_OPERATOR_SEARCH_API_KEY = data.azurerm_key_vault_secret.app_backend_CGN_OPERATOR_SEARCH_API_KEY.value
      EUCOVIDCERT_API_URL         = "http://${data.azurerm_function_app.fnapp_eucovidcert.default_hostname}/api/v1"
      EUCOVIDCERT_API_KEY         = data.azurerm_key_vault_secret.app_backend_EUCOVIDCERT_API_KEY.value

      // EXPOSED API
      API_BASE_PATH                     = "/api/v1"
      BONUS_API_BASE_PATH               = "/api/v1"
      CGN_API_BASE_PATH                 = "/api/v1/cgn"
      CGN_OPERATOR_SEARCH_API_BASE_PATH = "/api/v1/cgn/operator-search"
      EUCOVIDCERT_API_BASE_PATH         = "/api/v1/eucovidcert"
      MIT_VOUCHER_API_BASE_PATH         = "/api/v1/mitvoucher/auth"

      // REDIS
      REDIS_URL      = data.azurerm_redis_cache.redis_common.hostname
      REDIS_PORT     = data.azurerm_redis_cache.redis_common.ssl_port
      REDIS_PASSWORD = data.azurerm_redis_cache.redis_common.primary_access_key

      // PUSH NOTIFICATIONS
      PRE_SHARED_KEY               = data.azurerm_key_vault_secret.app_backend_PRE_SHARED_KEY.value
      ALLOW_NOTIFY_IP_SOURCE_RANGE = data.azurerm_subnet.fnapp_services_subnet_out.address_prefixes[0]

      // LOCK / UNLOCK SESSION ENDPOINTS
      ALLOW_SESSION_HANDLER_IP_SOURCE_RANGE = data.azurerm_subnet.fnapp_admin_subnet_out.address_prefixes[0]

      // PAGOPA
      PAGOPA_API_URL_PROD          = "https://${data.azurerm_app_service.pagopa_proxy_prod.default_site_hostname}"
      PAGOPA_API_URL_TEST          = "https://${data.azurerm_app_service.pagopa_proxy_test.default_site_hostname}"
      PAGOPA_BASE_PATH             = "/pagopa/api/v1"
      ALLOW_PAGOPA_IP_SOURCE_RANGE = data.azurerm_key_vault_secret.app_backend_ALLOW_PAGOPA_IP_SOURCE_RANGE.value

      // MYPORTAL
      MYPORTAL_BASE_PATH             = "/myportal/api/v1"
      ALLOW_MYPORTAL_IP_SOURCE_RANGE = data.azurerm_key_vault_secret.app_backend_ALLOW_MYPORTAL_IP_SOURCE_RANGE.value

      // MIT_VOUCHER JWT
      JWT_MIT_VOUCHER_TOKEN_ISSUER         = "app-backend.io.italia.it"
      JWT_MIT_VOUCHER_TOKEN_EXPIRATION     = 1200
      JWT_MIT_VOUCHER_TOKEN_PRIVATE_ES_KEY = data.azurerm_key_vault_secret.app_backend_JWT_MIT_VOUCHER_TOKEN_PRIVATE_ES_KEY.value
      JWT_MIT_VOUCHER_TOKEN_AUDIENCE       = data.azurerm_key_vault_secret.app_backend_JWT_MIT_VOUCHER_TOKEN_AUDIENCE.value

      // BPD
      BPD_BASE_PATH                     = "/bpd/api/v1"
      ALLOW_BPD_IP_SOURCE_RANGE         = data.azurerm_key_vault_secret.app_backend_ALLOW_BPD_IP_SOURCE_RANGE.value
      JWT_SUPPORT_TOKEN_PRIVATE_RSA_KEY = data.azurerm_key_vault_secret.app_backend_JWT_SUPPORT_TOKEN_PRIVATE_RSA_KEY.value

      // ZENDESK
      ZENDESK_BASE_PATH                    = "/api/backend/zendesk/v1"
      JWT_ZENDESK_SUPPORT_TOKEN_ISSUER     = "app-backend.io.italia.it"
      JWT_ZENDESK_SUPPORT_TOKEN_EXPIRATION = 1200
      JWT_ZENDESK_SUPPORT_TOKEN_SECRET     = data.azurerm_key_vault_secret.app_backend_JWT_ZENDESK_SUPPORT_TOKEN_SECRET.value
      ALLOW_ZENDESK_IP_SOURCE_RANGE        = data.azurerm_key_vault_secret.app_backend_ALLOW_ZENDESK_IP_SOURCE_RANGE.value

      SPID_LOG_QUEUE_NAME                = local.storage_account_notifications_queue_spidmsgitems
      SPID_LOG_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.logs.primary_connection_string

      NOTIFICATIONS_QUEUE_NAME                = local.storage_account_notifications_queue_push_notifications
      NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.notifications.primary_connection_string

      // USERSLOGIN
      USERS_LOGIN_QUEUE_NAME                = local.storage_account_notifications_queue_userslogin
      USERS_LOGIN_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.logs.primary_connection_string

      // Feature flags
      FF_BONUS_ENABLED          = 1
      FF_CGN_ENABLED            = 1
      FF_EUCOVIDCERT_ENABLED    = 1
      FF_MIT_VOUCHER_ENABLED    = 1
      FF_USER_AGE_LIMIT_ENABLED = 1

      // TEST LOGIN
      TEST_LOGIN_PASSWORD     = data.azurerm_key_vault_secret.app_backend_TEST_LOGIN_PASSWORD.value
      TEST_LOGIN_FISCAL_CODES = local.test_users

      // SUPPORT_TOKEN
      JWT_SUPPORT_TOKEN_ISSUER     = "app-backend.io.italia.it"
      JWT_SUPPORT_TOKEN_EXPIRATION = 1209600

      // MVL PECSERVER
      PECSERVER_URL          = "https://poc.pagopa.poste.it"
      PECSERVER_BASE_PATH    = ""
      PECSERVER_TOKEN_ISSUER = "app-backend.io.italia.it"
      PECSERVER_TOKEN_SECRET = data.azurerm_key_vault_secret.app_backend_PECSERVER_TOKEN_SECRET.value

      // CGN
      TEST_CGN_FISCAL_CODES = data.azurerm_key_vault_secret.app_backend_TEST_CGN_FISCAL_CODES.value
    }

    app_settings_l1 = {
      // FUNCTIONS
      API_URL = "http://${data.azurerm_function_app.fnapp_app1.default_hostname}/api/v1"
    }

    app_settings_l2 = {
      // FUNCTIONS
      API_URL = "http://${data.azurerm_function_app.fnapp_app2.default_hostname}/api/v1"
    }

    app_settings_li = {
      // FUNCTIONS
      API_URL = "http://${data.azurerm_function_app.fnapp_app1.default_hostname}/api/v1" # only used in internal app backend
    }
  }
}

resource "azurerm_resource_group" "rg_linux" {
  name     = format("%s-rg-linux", local.project)
  location = var.location

  tags = var.tags
}

## key vault

data "azurerm_key_vault_secret" "app_backend_SAML_CERT" {
  name         = "appbackend-SAML-CERT"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_SAML_KEY" {
  name         = "appbackend-SAML-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_API_KEY" {
  name         = "funcapp-KEY-APPBACKEND"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_BONUS_API_KEY" {
  name         = "funcbonus-KEY-APPBACKEND"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_CGN_API_KEY" {
  name         = "funccgn-KEY-APPBACKEND"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_CGN_OPERATOR_SEARCH_API_KEY" {
  name         = "funccgnoperatorsearch-KEY-APPBACKEND"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_EUCOVIDCERT_API_KEY" {
  name         = "funceucovidcert-KEY-APPBACKEND"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_PRE_SHARED_KEY" {
  name         = "appbackend-PRE-SHARED-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOW_PAGOPA_IP_SOURCE_RANGE" {
  name         = "appbackend-ALLOW-PAGOPA-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_TEST_LOGIN_PASSWORD" {
  name         = "appbackend-TEST-LOGIN-PASSWORD"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOW_MYPORTAL_IP_SOURCE_RANGE" {
  name         = "appbackend-ALLOW-MYPORTAL-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOW_BPD_IP_SOURCE_RANGE" {
  name         = "appbackend-ALLOW-BPD-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_JWT_SUPPORT_TOKEN_PRIVATE_RSA_KEY" {
  name         = "appbackend-JWT-SUPPORT-TOKEN-PRIVATE-RSA-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_TEST_CGN_FISCAL_CODES" {
  name         = "appbackend-TEST-CGN-FISCAL-CODES"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_JWT_MIT_VOUCHER_TOKEN_PRIVATE_ES_KEY" {
  name         = "appbackend-mitvoucher-JWT-PRIVATE-ES-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_JWT_MIT_VOUCHER_TOKEN_AUDIENCE" {
  name         = "appbackend-mitvoucher-JWT-AUDIENCE"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOW_ZENDESK_IP_SOURCE_RANGE" {
  name         = "appbackend-ALLOW-ZENDESK-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_JWT_ZENDESK_SUPPORT_TOKEN_SECRET" {
  name         = "appbackend-JWT-ZENDESK-SUPPORT-TOKEN-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "app_backend_PECSERVER_TOKEN_SECRET" {
  name         = "appbackend-PECSERVER-TOKEN-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

module "app_backendl1_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                 = "appbackendl1"
  address_prefixes     = var.cidr_subnet_appbackendl1
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "appservice_app_backendl1" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.0.13"

  # App service plan
  plan_type     = "internal"
  plan_name     = format("%s-plan-appappbackendl1", local.project)
  plan_kind     = "Linux"
  plan_reserved = true # Mandatory for Linux plan
  plan_sku_tier = var.app_backend_plan_sku_tier
  plan_sku_size = var.app_backend_plan_sku_size

  # App service
  name                = format("%s-app-appbackendl1", local.project)
  resource_group_name = azurerm_resource_group.rg_linux.name
  always_on           = true
  linux_fx_version    = "NODE|14-lts"
  app_command_line    = "node /home/site/wwwroot/src/server.js"
  health_check_path   = "/info"

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_l1,
  )

  allowed_subnets = [
    data.azurerm_subnet.fnapp_admin_subnet_out.id,
    data.azurerm_subnet.fnapp_services_subnet_out.id,
    module.appgateway_snet.id,
    module.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  # subnet_id = module.app_backendl1_snet.id

  tags = var.tags
}

module "app_backendl2_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                 = "appbackendl2"
  address_prefixes     = var.cidr_subnet_appbackendl2
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "appservice_app_backendl2" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.0.13"

  # App service plan
  plan_type     = "internal"
  plan_name     = format("%s-plan-appappbackendl2", local.project)
  plan_kind     = "Linux"
  plan_reserved = true # Mandatory for Linux plan
  plan_sku_tier = var.app_backend_plan_sku_tier
  plan_sku_size = var.app_backend_plan_sku_size

  # App service
  name                = format("%s-app-appbackendl2", local.project)
  resource_group_name = azurerm_resource_group.rg_linux.name
  always_on           = true
  linux_fx_version    = "NODE|14-lts"
  app_command_line    = "node /home/site/wwwroot/src/server.js"
  health_check_path   = "/info"

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_l2,
  )

  allowed_subnets = [
    data.azurerm_subnet.fnapp_admin_subnet_out.id,
    data.azurerm_subnet.fnapp_services_subnet_out.id,
    module.appgateway_snet.id,
    module.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  # subnet_id = module.app_backendl2_snet.id

  tags = var.tags
}

module "app_backendli_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                 = "appbackendli"
  address_prefixes     = var.cidr_subnet_appbackendli
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "appservice_app_backendli" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.0.13"

  # App service plan
  plan_type     = "internal"
  plan_name     = format("%s-plan-appappbackendli", local.project)
  plan_kind     = "Linux"
  plan_reserved = true # Mandatory for Linux plan
  plan_sku_tier = var.app_backend_plan_sku_tier
  plan_sku_size = var.app_backend_plan_sku_size

  # App service
  name                = format("%s-app-appbackendli", local.project)
  resource_group_name = azurerm_resource_group.rg_linux.name
  always_on           = true
  linux_fx_version    = "NODE|14-lts"
  app_command_line    = "node /home/site/wwwroot/src/server.js"
  health_check_path   = "/info"

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_li,
  )

  allowed_subnets = [
    data.azurerm_subnet.fnapp_admin_subnet_out.id,
    data.azurerm_subnet.fnapp_services_subnet_out.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  # subnet_id = module.app_backendli_snet.id

  tags = var.tags
}
