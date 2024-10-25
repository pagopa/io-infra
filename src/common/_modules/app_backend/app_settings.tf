locals {
  app_settings_common = {
    IS_APPBACKENDLI = var.is_li ? "true" : "false"
    # No downtime on slots swap
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    WEBSITE_DNS_SERVER                              = "168.63.129.16"

    APPINSIGHTS_INSTRUMENTATIONKEY = var.ai_instrumentation_key

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


    // AUTHENTICATION
    AUTHENTICATION_BASE_PATH = ""

    // FUNCTIONS
    API_URL                     = "https://${var.backend_hostnames.app[1]}/api/v1"
    API_KEY                     = data.azurerm_key_vault_secret.app_backend_API_KEY.value
    CGN_API_URL                 = "https://${var.backend_hostnames.cgn}"
    CGN_API_KEY                 = data.azurerm_key_vault_secret.app_backend_CGN_API_KEY.value
    IO_SIGN_API_URL             = "https://${var.backend_hostnames.iosign}"
    IO_SIGN_API_KEY             = data.azurerm_key_vault_secret.app_backend_IO_SIGN_API_KEY.value
    CGN_OPERATOR_SEARCH_API_URL = "https://${var.backend_hostnames.cgnonboarding}" # prod subscription
    CGN_OPERATOR_SEARCH_API_KEY = data.azurerm_key_vault_secret.app_backend_CGN_OPERATOR_SEARCH_API_KEY_PROD.value
    EUCOVIDCERT_API_URL         = "https://${var.backend_hostnames.eucovidcert}/api/v1"
    EUCOVIDCERT_API_KEY         = data.azurerm_key_vault_secret.fn_eucovidcert_API_KEY_APPBACKEND.value
    APP_MESSAGES_API_URL        = "https://${var.backend_hostnames.app_messages[(var.index - 1) % local.app_messages_count]}/api/v1"
    APP_MESSAGES_API_KEY        = data.azurerm_key_vault_secret.app_backend_APP_MESSAGES_API_KEY[(var.index - 1) % local.app_messages_count].value
    LOLLIPOP_API_URL            = "https://${var.backend_hostnames.lollipop}"
    LOLLIPOP_API_KEY            = data.azurerm_key_vault_secret.app_backend_LOLLIPOP_ITN_API_KEY.value
    TRIAL_SYSTEM_API_URL        = "https://${var.backend_hostnames.trial_system_api}" # PROD-TRIAL subscription
    TRIAL_SYSTEM_APIM_URL       = var.backend_hostnames.trial_system_apim             # Add this variable to avoid downtime
    TRIAL_SYSTEM_API_KEY        = data.azurerm_key_vault_secret.app_backend_TRIAL_SYSTEM_API_KEY.value
    TRIAL_SYSTEM_APIM_KEY       = data.azurerm_key_vault_secret.app_backend_TRIAL_SYSTEM_APIM_KEY.value
    IO_WALLET_API_URL           = "https://${var.backend_hostnames.iowallet}"
    IO_WALLET_API_KEY           = data.azurerm_key_vault_secret.app_backend_IO_WALLET_API_KEY.value

    // EXPOSED API
    API_BASE_PATH                     = "/api/v1"
    CGN_API_BASE_PATH                 = "/api/v1/cgn"
    CGN_OPERATOR_SEARCH_API_BASE_PATH = "/api/v1/cgn/operator-search"
    EUCOVIDCERT_API_BASE_PATH         = "/api/v1/eucovidcert"
    IO_SIGN_API_BASE_PATH             = "/api/v1/sign"
    LOLLIPOP_API_BASE_PATH            = "/api/v1"
    TRIAL_SYSTEM_API_BASE_PATH        = "/api/v1"
    TRIAL_SYSTEM_APIM_BASE_PATH       = "/manage/api/v1"
    IO_WALLET_API_BASE_PATH           = "/api/v1/wallet"

    // REDIS
    REDIS_URL      = var.redis_common.hostname
    REDIS_PORT     = var.redis_common.ssl_port
    REDIS_PASSWORD = var.redis_common.primary_access_key

    // PUSH NOTIFICATIONS
    PRE_SHARED_KEY               = data.azurerm_key_vault_secret.app_backend_PRE_SHARED_KEY.value
    ALLOW_NOTIFY_IP_SOURCE_RANGE = "127.0.0.0/0"

    // LOCK / UNLOCK SESSION ENDPOINTS
    ALLOW_SESSION_HANDLER_IP_SOURCE_RANGE = var.apim_snet_address_prefixes[0]

    // PAGOPA
    PAGOPA_API_URL_PROD = "https://api.platform.pagopa.it/checkout/auth/payments/v1"
    PAGOPA_API_URL_TEST = "https://api.uat.platform.pagopa.it/checkout/auth/payments/v1"
    PAGOPA_API_KEY_PROD = data.azurerm_key_vault_secret.app_backend_PAGOPA_API_KEY_PROD.value
    PAGOPA_API_KEY_UAT  = data.azurerm_key_vault_secret.app_backend_PAGOPA_API_KEY_UAT.value

    // MYPORTAL
    MYPORTAL_BASE_PATH             = "/myportal/api/v1"
    ALLOW_MYPORTAL_IP_SOURCE_RANGE = data.azurerm_key_vault_secret.app_backend_ALLOW_MYPORTAL_IP_SOURCE_RANGE.value

    // BPD
    JWT_SUPPORT_TOKEN_PRIVATE_RSA_KEY = data.azurerm_key_vault_secret.app_backend_JWT_SUPPORT_TOKEN_PRIVATE_RSA_KEY.value

    NOTIFICATIONS_QUEUE_NAME                = "push-notifications"
    NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.notifications.primary_connection_string

    PUSH_NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.push_notifications_storage.primary_connection_string
    PUSH_NOTIFICATIONS_QUEUE_NAME                = "push-notifications"

    LOCKED_PROFILES_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.locked_profiles_storage.primary_connection_string
    LOCKED_PROFILES_TABLE_NAME                = "lockedprofiles"

    // Feature flags
    FF_BONUS_ENABLED           = 1
    FF_CGN_ENABLED             = 1
    FF_EUCOVIDCERT_ENABLED     = 1
    FF_IO_SIGN_ENABLED         = 1
    FF_IO_WALLET_ENABLED       = 1
    FF_IO_WALLET_TRIAL_ENABLED = 1

    FF_ROUTING_PUSH_NOTIF                      = "ALL" # possible values are: BETA, CANARY, ALL, NONE
    FF_ROUTING_PUSH_NOTIF_BETA_TESTER_SHA_LIST = data.azurerm_key_vault_secret.app_backend_APP_MESSAGES_BETA_FISCAL_CODES.value
    # ~31% of users
    FF_ROUTING_PUSH_NOTIF_CANARY_SHA_USERS_REGEX = "^([(0-9)|(a-f)|(A-F)]{63}[(0-4)]{1})$"

    FF_PN_ACTIVATION_ENABLED = "1"
    FF_TRIAL_SYSTEM_ENABLED  = "1"

    // SUPPORT_TOKEN
    JWT_SUPPORT_TOKEN_ISSUER     = "app-backend.io.italia.it"
    JWT_SUPPORT_TOKEN_EXPIRATION = 1209600

    // these old MVL properties must be dismissed after we dismiss staging version
    PECSERVER_URL          = "https://poc.pagopa.poste.it"
    PECSERVER_BASE_PATH    = ""
    PECSERVER_TOKEN_ISSUER = "app-backend.io.italia.it"
    PECSERVER_TOKEN_SECRET = data.azurerm_key_vault_secret.app_backend_PECSERVER_TOKEN_SECRET.value

    // MVL PECSERVER
    PECSERVERS_poste_url       = "https://poc.pagopa.poste.it"
    PECSERVERS_poste_basePath  = ""
    PECSERVERS_poste_secret    = data.azurerm_key_vault_secret.app_backend_PECSERVER_TOKEN_SECRET.value
    PECSERVERS_poste_serviceId = "01FQ4945RG5WJGPHKY8ZYRJMQ7"
    PECSERVERS_aruba_url       = "https://pagopa-test.pec.aruba.it"
    PECSERVERS_aruba_basePath  = "/apigateway/api/v2/pagopa/mailbox"
    PECSERVERS_aruba_secret    = data.azurerm_key_vault_secret.app_backend_PECSERVER_ARUBA_TOKEN_SECRET.value
    PECSERVERS_aruba_serviceId = "01FRMRD5P7H378MDXBBW3DTYCF"

    // CGN
    TEST_CGN_FISCAL_CODES = "" #data.azurerm_key_vault_secret.app_backend_TEST_CGN_FISCAL_CODES.value

    // Service ID PN
    PN_SERVICE_ID = local.service_ids.pn

    // Remote content configuration id of PN
    PN_CONFIGURATION_ID = local.service_ids.pn_remote_config

    // Service ID IO-SIGN
    IO_SIGN_SERVICE_ID = local.service_ids.io_sign

    // IO Wallet TRIAL ID
    IO_WALLET_TRIAL_ID = local.service_ids.io_wallet_trial

    // PN Service Activation
    PN_ACTIVATION_BASE_PATH = "/api/v1/pn"
    PN_API_KEY              = data.azurerm_key_vault_secret.app_backend_PN_API_KEY_PROD.value
    PN_API_KEY_UAT          = data.azurerm_key_vault_secret.app_backend_PN_API_KEY_UAT_V2.value
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
          baseUrl = "https://io-p-sign-user-func.azurewebsites.net/api/v1/sign",
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

    // LolliPOP
    LOLLIPOP_REVOKE_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.lollipop_assertions_storage.primary_connection_string
    LOLLIPOP_REVOKE_QUEUE_NAME                = local.citizen_auth_revoke_queue_name

    // UNIQUE EMAIL ENFORCEMENT
    FF_UNIQUE_EMAIL_ENFORCEMENT    = "ALL"
    UNIQUE_EMAIL_ENFORCEMENT_USERS = join(",", [data.azurerm_key_vault_secret.app_backend_UNIQUE_EMAIL_ENFORCEMENT_USER.value, module.tests.users.unique_email_test[0]])

    // DEPRECATED APP SETTINGS
    // The following variables must be removed after a update
    // of the io-backend configuration, because they are required to start
    // the application.
    BONUS_API_BASE_PATH = "/api/v1"
    BONUS_API_URL       = "to-remove"
    BONUS_API_KEY       = "to-remove"

    // Services App Backend
    SERVICES_APP_BACKEND_BASE_PATH     = "/api/v2"
    SERVICES_APP_BACKEND_API_URL       = "https://${var.backend_hostnames.services_app_backend}"
    SERVICES_APP_BACKEND_API_BASE_PATH = "/api/v1"
  }
}
