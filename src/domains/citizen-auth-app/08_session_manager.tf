###########
# SECRETS #
###########
data "azurerm_key_vault_secret" "session_manager_functions_profile_api_key" {
  name         = "session-manager-functions-profile-api-key"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "functions_fast_login_api_key" {
  name         = "session-manager-functions-fast-login-api-key"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "functions_lollipop_api_key" {
  name         = "session-manager-lollipop-functions-api-key"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "app_backend_LV_TEST_USERS" {
  name         = "appbackend-LV-TEST-USERS"
  key_vault_id = data.azurerm_key_vault.kv_common.id
}

data "azurerm_key_vault_secret" "app_backend_SAML_CERT" {
  name         = "appbackend-SAML-CERT"
  key_vault_id = data.azurerm_key_vault.kv_common.id
}

data "azurerm_key_vault_secret" "app_backend_SAML_KEY" {
  name         = "appbackend-SAML-KEY"
  key_vault_id = data.azurerm_key_vault.kv_common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOWED_CIE_TEST_FISCAL_CODES" {
  name         = "appbackend-ALLOWED-CIE-TEST-FISCAL-CODES"
  key_vault_id = data.azurerm_key_vault.kv_common.id
}

data "azurerm_key_vault_secret" "session_manager_TEST_LOGIN_PASSWORD" {
  name         = "session-manager-TEST-LOGIN-PASSWORD"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "session_manager_JWT_ZENDESK_SUPPORT_TOKEN_SECRET" {
  name         = "session-manager-JWT-ZENDESK-SUPPORT-TOKEN-SECRET"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "session_manager_ALLOW_ZENDESK_IP_SOURCE_RANGE" {
  name         = "session-manager-ALLOW-ZENDESK-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "session_manager_ALLOW_BPD_IP_SOURCE_RANGE" {
  name         = "session-manager-ALLOW-BPD-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "session_manager_ALLOW_PAGOPA_IP_SOURCE_RANGE" {
  name         = "session-manager-ALLOW-PAGOPA-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "session_manager_ALLOW_FIMS_IP_SOURCE_RANGE" {
  name         = "session-manager-ALLOW-FIMS-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "session_manager_UNIQUE_EMAIL_ENFORCEMENT_USER" {
  name         = "session-manager-UNIQUE-EMAIL-ENFORCEMENT-USER"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "session_manager_IOLOGIN_TEST_USERS" {
  name         = "session-manager-IOLOGIN-TEST-USERS"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_key_vault_secret" "session_manager_VALIDATION_COOKIE_TEST_USERS" {
  name         = "session-manager-VALIDATION-COOKIE-TEST-USERS"
  key_vault_id = data.azurerm_key_vault.auth.id
}

data "azurerm_linux_function_app" "itn_auth_lv_func" {
  name                = "${local.short_project_itn}-lv-func-02"
  resource_group_name = "${local.short_project_itn}-lv-rg-01"
}

###########

data "azurerm_resource_group" "session_manager_rg_weu" {
  name = format("%s-session-manager-rg-01", local.common_project)
}

locals {

  app_name_weu = format("%s-session-manager-app", local.common_project)

  app_settings_common = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080

    WEBSITE_NODE_DEFAULT_VERSION = "20.12.2"
    WEBSITE_RUN_FROM_PACKAGE     = "1"

    // HEALTHCHECK VARIABLES
    WEBSITE_SWAP_WARMUP_PING_PATH     = "/healthcheck"
    WEBSITE_SWAP_WARMUP_PING_STATUSES = "200"

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

    # APPINSIGHTS
    APPINSIGHTS_CONNECTION_STRING   = data.azurerm_application_insights.application_insights.connection_string
    APPINSIGHTS_DISABLED            = false
    APPINSIGHTS_SAMPLING_PERCENTAGE = 30
    APPINSIGHTS_REDIS_TRACE_ENABLED = "true"

    API_BASE_PATH = "/api/v1"

    # Fims config
    FIMS_BASE_PATH             = "/fims/api/v1"
    ALLOW_FIMS_IP_SOURCE_RANGE = data.azurerm_key_vault_secret.session_manager_ALLOW_FIMS_IP_SOURCE_RANGE.value

    # REDIS AUTHENTICATION
    REDIS_URL      = data.azurerm_redis_cache.core_domain_redis_common.hostname
    REDIS_PORT     = data.azurerm_redis_cache.core_domain_redis_common.ssl_port
    REDIS_PASSWORD = data.azurerm_redis_cache.core_domain_redis_common.primary_access_key

    # Functions App config
    API_KEY = data.azurerm_key_vault_secret.session_manager_functions_profile_api_key.value
    API_URL = "https://io-p-itn-auth-profile-func-02.azurewebsites.net"

    # Functions Fast Login config
    FAST_LOGIN_API_KEY = data.azurerm_key_vault_secret.functions_fast_login_api_key.value
    FAST_LOGIN_API_URL = "https://${data.azurerm_linux_function_app.itn_auth_lv_func.default_hostname}"

    # Functions Lollipop config
    LOLLIPOP_API_BASE_PATH = "/api/v1"
    LOLLIPOP_API_URL       = "https://${data.azurerm_linux_function_app.function_lollipop_itn_v2.default_hostname}"
    LOLLIPOP_API_KEY       = data.azurerm_key_vault_secret.functions_lollipop_api_key.value

    LOLLIPOP_REVOKE_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.auth_session_storage.primary_connection_string
    LOLLIPOP_REVOKE_QUEUE_NAME                = "pubkeys-revoke-01"

    # Fast Login config
    FF_FAST_LOGIN = "ALL"
    # TODO: change this variable to a list of regex to reduce characters and fix
    # E2BIG errors on linux spawn syscall when using PM2
    LV_TEST_USERS = module.tests.users.light

    # IOLOGIN redirect
    FF_IOLOGIN         = "BETA"
    IOLOGIN_TEST_USERS = data.azurerm_key_vault_secret.session_manager_IOLOGIN_TEST_USERS.value
    # Takes ~6,25% of users
    IOLOGIN_CANARY_USERS_REGEX = "^([(0-9)|(a-f)|(A-F)]{63}0)$"

    # Test Login config
    TEST_LOGIN_PASSWORD = data.azurerm_key_vault_secret.session_manager_TEST_LOGIN_PASSWORD.value
    // base64 encode of the compressed string (using gzip algorithm)
    TEST_LOGIN_FISCAL_CODES_COMPRESSED = base64gzip(module.tests.users.all)


    BACKEND_HOST = "https://${trimsuffix(data.azurerm_dns_a_record.api_app_io_pagopa_it.fqdn, ".")}"

    # Locked profile storage
    LOCKED_PROFILES_STORAGE_CONNECTION_STRING = module.locked_profiles_storage.primary_connection_string
    LOCKED_PROFILES_TABLE_NAME                = azurerm_storage_table.locked_profiles.name

    # Spid logs config
    SPID_LOG_QUEUE_NAME                = "spidmsgitems"
    SPID_LOG_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.logs.primary_connection_string

    # Spid config
    SAML_CALLBACK_URL                      = "https://app-backend.io.italia.it/assertionConsumerService"
    SAML_CERT                              = trimspace(data.azurerm_key_vault_secret.app_backend_SAML_CERT.value)
    SAML_KEY                               = trimspace(data.azurerm_key_vault_secret.app_backend_SAML_KEY.value)
    SAML_LOGOUT_CALLBACK_URL               = "https://app-backend.io.italia.it/slo"
    SAML_ISSUER                            = "https://app-backend.io.italia.it"
    SAML_ATTRIBUTE_CONSUMING_SERVICE_INDEX = "0"
    SAML_ACCEPTED_CLOCK_SKEW_MS            = "5000"
    # IDP_METADATA_URL                       = "https://registry.SPID.gov.it/metadata/idp/spid-entities-idps.xml"
    IDP_METADATA_URL                      = "https://api.is.eng.pagopa.it/idp-keys/spid/latest" # PagoPA internal cache
    IDP_METADATA_REFRESH_INTERVAL_SECONDS = "864000"                                            # 10 days

    # CIE config
    # CIE_METADATA_URL = "https://idserver.servizicie.interno.gov.it:443/idp/shibboleth"
    CIE_METADATA_URL              = "https://api.is.eng.pagopa.it/idp-keys/cie/latest" # PagoPA internal cache
    ALLOWED_CIE_TEST_FISCAL_CODES = data.azurerm_key_vault_secret.app_backend_ALLOWED_CIE_TEST_FISCAL_CODES.value
    CIE_TEST_METADATA_URL         = "https://collaudo.idserver.servizicie.interno.gov.it/idp/shibboleth"

    PUSH_NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.push_notifications_storage.primary_connection_string
    PUSH_NOTIFICATIONS_QUEUE_NAME                = local.storage_account_notifications_queue_push_notifications

    # ZENDESK config
    ZENDESK_BASE_PATH                    = "/api/backend/zendesk/v1"
    JWT_ZENDESK_SUPPORT_TOKEN_ISSUER     = "app-backend.io.italia.it"
    JWT_ZENDESK_SUPPORT_TOKEN_EXPIRATION = 1200
    JWT_ZENDESK_SUPPORT_TOKEN_SECRET     = data.azurerm_key_vault_secret.session_manager_JWT_ZENDESK_SUPPORT_TOKEN_SECRET.value
    ALLOW_ZENDESK_IP_SOURCE_RANGE        = data.azurerm_key_vault_secret.session_manager_ALLOW_ZENDESK_IP_SOURCE_RANGE.value

    # BPD config
    BPD_BASE_PATH             = "/bpd/api/v1"
    ALLOW_BPD_IP_SOURCE_RANGE = data.azurerm_key_vault_secret.session_manager_ALLOW_BPD_IP_SOURCE_RANGE.value

    # PAGOPA config
    PAGOPA_BASE_PATH             = "/pagopa/api/v1"
    ALLOW_PAGOPA_IP_SOURCE_RANGE = data.azurerm_key_vault_secret.session_manager_ALLOW_PAGOPA_IP_SOURCE_RANGE.value

    # Validation Cookie config
    VALIDATION_COOKIE_DURATION_MS = 900000
    FF_VALIDATION_COOKIE          = "ALL"
    VALIDATION_COOKIE_TEST_USERS  = data.azurerm_key_vault_secret.session_manager_VALIDATION_COOKIE_TEST_USERS.value

    # ServiceBus Auth Event Config
    SERVICE_BUS_NAMESPACE    = "${data.azurerm_servicebus_namespace.platform_service_bus_namespace.name}.servicebus.windows.net"
    AUTH_SESSIONS_TOPIC_NAME = local.auth_sessions_topic_name

  }
}

locals {
  PM2_E2BIG_THRESHOLD = 32000
  # This check prevents changes that would crash the app service that
  # uses PM2 under the hood
  VALIDATION_CHECK_E2BIG = length(local.app_settings_common.TEST_LOGIN_FISCAL_CODES_COMPRESSED) < local.PM2_E2BIG_THRESHOLD ? "" : file("[ERROR] Validation check failed for test users length.")
}

#################################
## Session Manager App service ##
#################################

// NOTE: If duplicating this service, ensure that write permissions on the session topic
// are granted before enabling production traffic.
// see reference https://github.com/pagopa/io-auth-n-identity-domain/blob/303a5659791ce95b529c557f4aa4400e7e51e9a7/infra/resources/prod/servicebus_topic.tf#L61
module "session_manager_weu" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service?ref=v8.28.1"

  # App service plan
  plan_type              = "internal"
  plan_name              = format("%s-session-manager-asp-03", local.common_project)
  zone_balancing_enabled = true
  sku_name               = var.session_manager_plan_sku_name

  # App service
  name                = "${local.app_name_weu}-03"
  resource_group_name = data.azurerm_resource_group.session_manager_rg_weu.name
  location            = var.location

  always_on    = true
  node_version = "20-lts"
  # NOTE:
  # 1. index.js file is generated from the deploy pipeline
  # 2. the linux container for app services already has pm2 installed
  #    (refer to https://learn.microsoft.com/en-us/azure/app-service/configure-language-nodejs?pivots=platform-linux#run-with-pm2)
  app_command_line             = "pm2 start index.js -i max --no-daemon"
  health_check_path            = "/healthcheck"
  health_check_maxpingfailures = 2

  auto_heal_enabled = true
  auto_heal_settings = {
    startup_time           = "00:05:00"
    slow_requests_count    = 50
    slow_requests_interval = "00:01:00"
    slow_requests_time     = "00:00:10"
  }

  app_settings = merge(
    local.app_settings_common,
    {
      APPINSIGHTS_CLOUD_ROLE_NAME = "${local.app_name_weu}-03"
    }
  )
  sticky_settings = concat(["APPINSIGHTS_CLOUD_ROLE_NAME"])


  allowed_subnets = [
    data.azurerm_subnet.appgateway_snet.id,
    data.azurerm_subnet.apim_itn_snet.id,
  ]
  allowed_ips = []

  subnet_id                     = module.session_manager_snet.id
  vnet_integration              = true
  public_network_access_enabled = false

  tags = var.tags
}

## staging slot
module "session_manager_weu_staging" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service_slot?ref=v8.28.1"

  app_service_id   = module.session_manager_weu.id
  app_service_name = module.session_manager_weu.name

  name                = "staging"
  resource_group_name = data.azurerm_resource_group.session_manager_rg_weu.name
  location            = var.location

  always_on    = true
  node_version = "20-lts"
  # NOTE:
  # 1. index.js file is generated from the deploy pipeline
  # 2. the linux container for app services already has pm2 installed
  #    (refer to https://learn.microsoft.com/en-us/azure/app-service/configure-language-nodejs?pivots=platform-linux#run-with-pm2)
  app_command_line  = "pm2 start index.js -i max --no-daemon"
  health_check_path = "/healthcheck"

  auto_heal_enabled = true
  auto_heal_settings = {
    startup_time           = "00:05:00"
    slow_requests_count    = 50
    slow_requests_interval = "00:01:00"
    slow_requests_time     = "00:00:10"
  }

  app_settings = merge(
    local.app_settings_common,
    {
      APPINSIGHTS_CLOUD_ROLE_NAME = "${module.session_manager_weu.name}-staging"
    }
  )

  allowed_subnets = [
    # self hosted runners subnet
    data.azurerm_subnet.self_hosted_runner_snet.id,
    data.azurerm_subnet.appgateway_snet.id,
    data.azurerm_subnet.apim_itn_snet.id,
  ]
  allowed_ips = []

  subnet_id                     = module.session_manager_snet.id
  vnet_integration              = true
  public_network_access_enabled = false

  tags = var.tags
}

module "session_manager_weu_bis" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service?ref=v8.28.1"

  # App service plan
  plan_type              = "internal"
  plan_name              = format("%s-session-manager-asp-04", local.common_project)
  zone_balancing_enabled = true
  sku_name               = var.session_manager_plan_sku_name

  # App service
  name                = "${local.app_name_weu}-04"
  resource_group_name = data.azurerm_resource_group.session_manager_rg_weu.name
  location            = var.location

  always_on    = true
  node_version = "20-lts"
  # NOTE:
  # 1. index.js file is generated from the deploy pipeline
  # 2. the linux container for app services already has pm2 installed
  #    (refer to https://learn.microsoft.com/en-us/azure/app-service/configure-language-nodejs?pivots=platform-linux#run-with-pm2)
  app_command_line             = "pm2 start index.js -i max --no-daemon"
  health_check_path            = "/healthcheck"
  health_check_maxpingfailures = 2

  auto_heal_enabled = true
  auto_heal_settings = {
    startup_time           = "00:05:00"
    slow_requests_count    = 50
    slow_requests_interval = "00:01:00"
    slow_requests_time     = "00:00:10"
  }

  app_settings = merge(
    local.app_settings_common,
    {
      APPINSIGHTS_CLOUD_ROLE_NAME = "${local.app_name_weu}-04"
    }
  )
  sticky_settings = concat(["APPINSIGHTS_CLOUD_ROLE_NAME"])


  allowed_subnets = [
    data.azurerm_subnet.appgateway_snet.id,
    data.azurerm_subnet.apim_itn_snet.id,
  ]
  allowed_ips = []

  subnet_id                     = module.session_manager_bis_snet.id
  vnet_integration              = true
  public_network_access_enabled = false

  tags = var.tags
}

## staging slot
module "session_manager_weu_bis_staging" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service_slot?ref=v8.28.1"

  app_service_id   = module.session_manager_weu_bis.id
  app_service_name = module.session_manager_weu_bis.name

  name                = "staging"
  resource_group_name = data.azurerm_resource_group.session_manager_rg_weu.name
  location            = var.location

  always_on    = true
  node_version = "20-lts"
  # NOTE:
  # 1. index.js file is generated from the deploy pipeline
  # 2. the linux container for app services already has pm2 installed
  #    (refer to https://learn.microsoft.com/en-us/azure/app-service/configure-language-nodejs?pivots=platform-linux#run-with-pm2)
  app_command_line  = "pm2 start index.js -i max --no-daemon"
  health_check_path = "/healthcheck"

  auto_heal_enabled = true
  auto_heal_settings = {
    startup_time           = "00:05:00"
    slow_requests_count    = 50
    slow_requests_interval = "00:01:00"
    slow_requests_time     = "00:00:10"
  }

  app_settings = merge(
    local.app_settings_common,
    {
      APPINSIGHTS_CLOUD_ROLE_NAME = "${module.session_manager_weu_bis.name}-staging"
    }
  )

  allowed_subnets = [
    # self hosted runners subnet
    data.azurerm_subnet.self_hosted_runner_snet.id,
    data.azurerm_subnet.appgateway_snet.id,
    data.azurerm_subnet.apim_itn_snet.id,
  ]
  allowed_ips = []

  subnet_id                     = module.session_manager_bis_snet.id
  vnet_integration              = true
  public_network_access_enabled = false

  tags = var.tags
}

// Staging permissions over SB session topic
module "pub_session_manager_staging" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~>1.0"

  principal_id    = module.session_manager_weu_staging.principal_id
  subscription_id = data.azurerm_subscription.current.subscription_id

  service_bus = [
    {
      namespace_name      = data.azurerm_servicebus_namespace.platform_service_bus_namespace.name
      resource_group_name = data.azurerm_servicebus_namespace.platform_service_bus_namespace.resource_group_name
      role                = "writer"
      description         = "This role allows managing the given topic"
      topic_names         = [local.auth_sessions_topic_name]
    }
  ]
}

// Staging permissions over SB session topic
module "pub_session_manager_bis_staging" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~>1.0"

  principal_id    = module.session_manager_weu_bis_staging.principal_id
  subscription_id = data.azurerm_subscription.current.subscription_id

  service_bus = [
    {
      namespace_name      = data.azurerm_servicebus_namespace.platform_service_bus_namespace.name
      resource_group_name = data.azurerm_servicebus_namespace.platform_service_bus_namespace.resource_group_name
      role                = "writer"
      description         = "This role allows managing the given topic"
      topic_names         = [local.auth_sessions_topic_name]
    }
  ]
}
