###########
# SECRETS #
###########
data "azurerm_key_vault_secret" "functions_app_api_key" {
  name         = "session-manager-functions-app-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "functions_fast_login_api_key" {
  name         = "session-manager-functions-fast-login-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "functions_lollipop_api_key" {
  name         = "session-manager-functions-lollipop-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
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
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "session_manager_JWT_ZENDESK_SUPPORT_TOKEN_SECRET" {
  name         = "session-manager-JWT-ZENDESK-SUPPORT-TOKEN-SECRET"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "session_manager_ALLOW_ZENDESK_IP_SOURCE_RANGE" {
  name         = "session-manager-ALLOW-ZENDESK-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "session_manager_ALLOW_BPD_IP_SOURCE_RANGE" {
  name         = "session-manager-ALLOW-BPD-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "session_manager_ALLOW_PAGOPA_IP_SOURCE_RANGE" {
  name         = "session-manager-ALLOW-PAGOPA-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "session_manager_ALLOW_FIMS_IP_SOURCE_RANGE" {
  name         = "session-manager-ALLOW-FIMS-IP-SOURCE-RANGE"
  key_vault_id = data.azurerm_key_vault.kv.id
}

###########

resource "azurerm_resource_group" "session_manager_rg_weu" {
  name     = format("%s-session-manager-rg-01", local.common_project)
  location = var.location

  tags = var.tags
}

locals {

  app_name     = format("%s-session-manager-app-02", local.common_project)
  app_name_weu = format("%s-session-manager-app-03", local.common_project)

  app_settings_common = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080

    WEBSITE_NODE_DEFAULT_VERSION = "20.12.2"
    WEBSITE_RUN_FROM_PACKAGE     = "1"

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
    APPINSIGHTS_SAMPLING_PERCENTAGE = 100

    API_BASE_PATH = "/api/v1"

    # Fims config
    FIMS_BASE_PATH             = "/fims/api/v1"
    ALLOW_FIMS_IP_SOURCE_RANGE = data.azurerm_key_vault_secret.session_manager_ALLOW_FIMS_IP_SOURCE_RANGE.value

    # REDIS AUTHENTICATION
    REDIS_URL      = data.azurerm_redis_cache.core_domain_redis_common.hostname
    REDIS_PORT     = data.azurerm_redis_cache.core_domain_redis_common.ssl_port
    REDIS_PASSWORD = data.azurerm_redis_cache.core_domain_redis_common.primary_access_key

    # Functions App config
    API_KEY = data.azurerm_key_vault_secret.functions_app_api_key.value
    API_URL = "https://io-p-app-fn-1.azurewebsites.net"

    # Functions Fast Login config
    FAST_LOGIN_API_KEY = data.azurerm_key_vault_secret.functions_fast_login_api_key.value
    FAST_LOGIN_API_URL = var.fastlogin_enabled ? "https://${module.function_fast_login[0].default_hostname}" : ""

    # Functions Lollipop config
    FF_LOLLIPOP_ENABLED    = "1"
    LOLLIPOP_API_BASE_PATH = "/api/v1"
    LOLLIPOP_API_URL       = "https://${module.function_lollipop_itn.default_hostname}"
    LOLLIPOP_API_KEY       = data.azurerm_key_vault_secret.functions_lollipop_api_key.value

    LOLLIPOP_REVOKE_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.lollipop_assertion_storage.primary_connection_string
    LOLLIPOP_REVOKE_QUEUE_NAME                = "pubkeys-revoke"

    # Fast Login config
    FF_FAST_LOGIN = "ALL"
    LV_TEST_USERS = module.tests.test_users.all

    # Test Login config
    TEST_LOGIN_FISCAL_CODES = module.tests.test_users.all
    TEST_LOGIN_PASSWORD     = data.azurerm_key_vault_secret.session_manager_TEST_LOGIN_PASSWORD.value


    BACKEND_HOST = "https://${trimsuffix(data.azurerm_dns_a_record.api_app_io_pagopa_it.fqdn, ".")}"

    # Locked profile storage
    LOCKED_PROFILES_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.locked_profiles_storage.primary_connection_string
    LOCKED_PROFILES_TABLE_NAME                = "lockedprofiles"

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

    // USERSLOGIN
    USERS_LOGIN_QUEUE_NAME                = local.storage_account_notifications_queue_userslogin
    USERS_LOGIN_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.logs.primary_connection_string

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
  }
}

#################################
## Session Manager App service ##
#################################

module "session_manager_weu" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service?ref=v8.22.0"

  # App service plan
  plan_type              = "internal"
  plan_name              = format("%s-session-manager-asp-03", local.common_project)
  zone_balancing_enabled = true
  sku_name               = "P1v3"

  # App service
  name                = local.app_name_weu
  resource_group_name = azurerm_resource_group.session_manager_rg_weu.name
  location            = var.location

  always_on                    = true
  node_version                 = "18-lts"
  app_command_line             = "npm run start"
  health_check_path            = "/healthcheck"
  health_check_maxpingfailures = 3

  app_settings = merge(
    local.app_settings_common,
    {
      APPINSIGHTS_CLOUD_ROLE_NAME = local.app_name_weu
    }
  )
  sticky_settings = concat(["APPINSIGHTS_CLOUD_ROLE_NAME"])


  allowed_subnets = [
    data.azurerm_subnet.apim_v2_snet.id,
    data.azurerm_subnet.appgateway_snet.id,
    data.azurerm_subnet.fims_op_app_snet_01.id
    // TODO: add proxy subnet
  ]
  allowed_ips = []

  subnet_id        = module.session_manager_snet.id
  vnet_integration = true

  tags = var.tags
}

## staging slot
module "session_manager_weu_staging" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service_slot?ref=v8.22.0"

  app_service_id   = module.session_manager_weu.id
  app_service_name = module.session_manager_weu.name

  name                = "staging"
  resource_group_name = azurerm_resource_group.session_manager_rg_weu.name
  location            = var.location

  always_on         = true
  node_version      = "20-lts"
  app_command_line  = "npm run start"
  health_check_path = "/healthcheck"

  app_settings = merge(
    local.app_settings_common,
    {
      APPINSIGHTS_CLOUD_ROLE_NAME = "${module.session_manager_weu.name}-staging"
    }
  )

  allowed_subnets = [
    # self hosted runners subnet
    data.azurerm_subnet.self_hosted_runner_snet.id,
    #
    data.azurerm_subnet.apim_v2_snet.id,
    data.azurerm_subnet.appgateway_snet.id
    // TODO: add proxy subnet
  ]
  allowed_ips = []

  subnet_id        = module.session_manager_snet.id
  vnet_integration = true

  tags = var.tags
}

## autoscaling
resource "azurerm_monitor_autoscale_setting" "session_manager_weu_autoscale_setting" {
  name                = format("%s-autoscale-02", module.session_manager_weu.name)
  resource_group_name = azurerm_resource_group.session_manager_rg_weu.name
  location            = azurerm_resource_group.session_manager_rg_weu.location
  target_resource_id  = module.session_manager_weu.plan_id

  profile {
    name = "default"

    capacity {
      default = var.session_manager_autoscale_settings.autoscale_default
      minimum = var.session_manager_autoscale_settings.autoscale_minimum
      maximum = var.session_manager_autoscale_settings.autoscale_maximum
    }

    # Increase rules

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.session_manager_weu.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT1M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.session_manager_weu.plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT1M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 40
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    # Decrease rules

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.session_manager_weu.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT15M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 1500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT30M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.session_manager_weu.plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT15M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 15
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT30M"
      }
    }
  }
}
