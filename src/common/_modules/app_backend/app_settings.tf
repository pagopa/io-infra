locals {
  app_settings_common = {
    # No downtime on slots swap
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    WEBSITE_DNS_SERVER                              = "168.63.129.16"

    APPINSIGHTS_INSTRUMENTATIONKEY = var.ai_instrumentation_key
    APPINSIGHTS_CONNECTION_STRING  = var.ai_connection_string
    APPINSIGHTS_CLOUD_ROLE_NAME    = local.nonstandard.weu.app

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

    // see https://learn.microsoft.com/en-us/azure/app-service/monitor-instances-health-check?tabs=dotnet#configuration
    WEBSITE_HEALTHCHECK_MAXUNHEALTHYWORKERPERCENT = "95"

    // API KEY
    // optionally you can specify APP_BACKEND_SECONDARY_KEY
    // for rotation purposes
    APP_BACKEND_PRIMARY_KEY = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=appbackend-APP-BACKEND-PRIMARY-KEY)"

    // FUNCTIONS
    API_URL                     = "https://${var.backend_hostnames.app[0]}/api/v1"
    API_KEY                     = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=funcapp-KEY-APPBACKEND)"
    CGN_API_URL                 = "https://${var.backend_hostnames.cgn}"
    CGN_API_KEY                 = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=funccgn-KEY-APPBACKEND)"
    IO_SIGN_API_URL             = "https://${var.backend_hostnames.iosign}"
    IO_SIGN_API_KEY             = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=funciosign-KEY-APPBACKEND)"
    IO_FIMS_API_URL             = "https://${var.backend_hostnames.iofims}"
    IO_FIMS_API_KEY             = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=funciofims-KEY-APPBACKEND)"
    CGN_OPERATOR_SEARCH_API_URL = "https://${var.backend_hostnames.cgnonboarding}" # prod subscription
    CGN_OPERATOR_SEARCH_API_KEY = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=funccgnoperatorsearch-KEY-PROD-APPBACKEND)"
    APP_MESSAGES_API_URL        = "https://${var.backend_hostnames.com_citizen_func}/api/v1"
    APP_MESSAGES_API_KEY        = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=appbackend-COM-CITIZEN-FUNC-API-KEY)"
    LOLLIPOP_API_URL            = "https://${var.backend_hostnames.lollipop}"
    LOLLIPOP_API_KEY            = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=appbackend-LOLLIPOP-ITN-API-KEY)"
    CDC_SUPPORT_API_URL         = "https://${var.backend_hostnames.cdc_support}"
    CDC_SUPPORT_API_KEY         = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=funccdcsupport-KEY-APPBACKEND)"

    // EXPOSED API
    CGN_API_BASE_PATH                 = "/api/v1/cgn"
    CGN_OPERATOR_SEARCH_API_BASE_PATH = "/api/v1/cgn/operator-search"
    IO_SIGN_API_BASE_PATH             = "/api/v1/sign"
    IO_FIMS_API_BASE_PATH             = "/api/v1/fims"
    LOLLIPOP_API_BASE_PATH            = "/api/v1"
    CDC_SUPPORT_API_BASE_PATH         = "/api/v1"

    // PAGOPA ECOMMERCE
    PAGOPA_ECOMMERCE_BASE_URL     = "https://api.platform.pagopa.it/ecommerce/payment-requests-service/v1"
    PAGOPA_ECOMMERCE_UAT_BASE_URL = "https://api.uat.platform.pagopa.it/ecommerce/payment-requests-service/v1"
    PAGOPA_ECOMMERCE_API_KEY      = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=appbackend-PAGOPA-ECOMMERCE-API-KEY)"
    PAGOPA_ECOMMERCE_UAT_API_KEY  = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=appbackend-PAGOPA-ECOMMERCE-UAT-API-KEY)"

    // MYPORTAL
    MYPORTAL_BASE_PATH             = "/myportal/api/v1"
    ALLOW_MYPORTAL_IP_SOURCE_RANGE = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=appbackend-ALLOW-MYPORTAL-IP-SOURCE-RANGE)"

    // BPD
    JWT_SUPPORT_TOKEN_PRIVATE_RSA_KEY = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=appbackend-JWT-SUPPORT-TOKEN-PRIVATE-RSA-KEY)"

    NOTIFICATIONS_QUEUE_NAME                = "push-notifications"
    NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.notifications.primary_connection_string

    PUSH_NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.itn_com_st.primary_connection_string
    PUSH_NOTIFICATIONS_QUEUE_NAME                = "push-notifications"

    // Feature flags
    FF_CGN_ENABLED     = 1
    FF_CDC_ENABLED     = 1
    FF_IO_SIGN_ENABLED = 1
    FF_IO_FIMS_ENABLED = 1

    FF_ROUTING_PUSH_NOTIF                      = "ALL" # possible values are: BETA, CANARY, ALL, NONE
    FF_ROUTING_PUSH_NOTIF_BETA_TESTER_SHA_LIST = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=appbackend-APP-MESSAGES-BETA-FISCAL-CODES)"
    # ~31% of users
    FF_ROUTING_PUSH_NOTIF_CANARY_SHA_USERS_REGEX = "^([(0-9)|(a-f)|(A-F)]{63}[(0-4)]{1})$"

    FF_PN_ACTIVATION_ENABLED = "1"

    // SUPPORT_TOKEN
    JWT_SUPPORT_TOKEN_ISSUER     = "app-backend.io.italia.it"
    JWT_SUPPORT_TOKEN_EXPIRATION = 1209600

    // Service ID PN
    PN_SERVICE_ID = local.service_ids.pn

    // Remote content configuration id of PN
    PN_CONFIGURATION_ID = local.service_ids.pn_remote_config

    // Service ID IO-SIGN
    IO_SIGN_SERVICE_ID = local.service_ids.io_sign

    // PN Service Activation
    PN_ACTIVATION_BASE_PATH = "/api/v1/pn"
    PN_API_KEY              = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=appbackend-PN-API-KEY-PROD-ENV)"
    PN_API_KEY_UAT          = "@Microsoft.KeyVault(VaultName=${var.key_vault_common.name};SecretName=appbackend-PN-API-KEY-UAT-ENV-V2)"
    PN_API_URL              = local.endpoints.pn
    PN_API_URL_UAT          = local.endpoints.pn_test

    // Third Party Services
    THIRD_PARTY_CONFIG_LIST = jsonencode([
      # Piattaforma Notifiche
      {
        serviceId          = local.service_ids.pn,
        schemaKind         = "PN",
        jsonSchema         = "unused",
        isLollipopEnabled  = "true",
        disableLollipopFor = split(",", module.tests.users.light),
        prodEnvironment = {
          baseUrl = local.endpoints.pn,
          detailsAuthentication = {
            type            = "API_KEY",
            header_key_name = "x-api-key",
            key             = data.azurerm_key_vault_secret.app_backend_PN_API_KEY_PROD.value
          }
        },
        testEnvironment = {
          testUsers = split(",", module.tests.users.light),
          baseUrl   = local.endpoints.pn_test,
          detailsAuthentication = {
            type            = "API_KEY",
            header_key_name = "x-api-key",
            key             = data.azurerm_key_vault_secret.app_backend_PN_API_KEY_UAT_V2.value
          }
        }
      },
      # Firma con IO (io-sign)
      {
        serviceId          = local.service_ids.io_sign,
        schemaKind         = "IO-SIGN",
        jsonSchema         = "unused",
        isLollipopEnabled  = "false",
        disableLollipopFor = [],
        prodEnvironment = {
          baseUrl = "https://io-p-itn-sign-user-func-01.azurewebsites.net/api/v1/sign",
          detailsAuthentication = {
            type            = "API_KEY",
            header_key_name = "X-Functions-Key",
            key             = data.azurerm_key_vault_secret.app_backend_IO_SIGN_API_KEY.value
          }
        }
      },
      # Receipt Service TEST
      {
        serviceId          = local.service_ids.io_receipt_test,
        schemaKind         = "ReceiptService",
        jsonSchema         = "unused",
        isLollipopEnabled  = "false",
        disableLollipopFor = [],
        testEnvironment = {
          testUsers = [],
          baseUrl   = local.endpoints.io_receipt_test,
          detailsAuthentication = {
            type            = "API_KEY",
            header_key_name = "Ocp-Apim-Subscription-Key",
            key             = data.azurerm_key_vault_secret.app_backend_RECEIPT_SERVICE_TEST_API_KEY.value
          }
        }
      },
      # Receipt Service PROD
      {
        serviceId          = local.service_ids.io_receipt,
        schemaKind         = "ReceiptService",
        jsonSchema         = "unused",
        isLollipopEnabled  = "false",
        disableLollipopFor = [],
        prodEnvironment = {
          baseUrl = local.endpoints.io_receipt,
          detailsAuthentication = {
            type            = "API_KEY",
            header_key_name = "Ocp-Apim-Subscription-Key",
            key             = data.azurerm_key_vault_secret.app_backend_RECEIPT_SERVICE_API_KEY.value
          }
        }
      },
      # Mock Service
      {
        serviceId          = local.service_ids.third_party_mock,
        schemaKind         = "Mock",
        jsonSchema         = "unused",
        isLollipopEnabled  = "false",
        disableLollipopFor = [],
        prodEnvironment = {
          baseUrl = "https://pagopa.github.io/third-party-mock",
          detailsAuthentication = {
            type            = "API_KEY",
            header_key_name = "x-api-key",
            key             = "unused"
          }
        }
      }
    ])
  }
}
