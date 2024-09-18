### Common resources

locals {
  name = "l${var.index}"
  app_backend = {
    app_command_line = "npm run start"
    app_settings_common = {
      # No downtime on slots swap
      WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
      WEBSITE_RUN_FROM_PACKAGE                        = "1"
      WEBSITE_DNS_SERVER                              = "168.63.129.16"

      APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.application_insights.instrumentation_key

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
      API_KEY                     = data.azurerm_key_vault_secret.app_backend_API_KEY.value
      CGN_API_URL                 = "https://${data.azurerm_linux_function_app.function_cgn.default_hostname}"
      CGN_API_KEY                 = data.azurerm_key_vault_secret.app_backend_CGN_API_KEY.value
      IO_SIGN_API_URL             = "https://io-p-sign-user-func.azurewebsites.net"
      IO_SIGN_API_KEY             = data.azurerm_key_vault_secret.app_backend_IO_SIGN_API_KEY.value
      CGN_OPERATOR_SEARCH_API_URL = "https://cgnonboardingportal-p-op.azurewebsites.net" # prod subscription
      CGN_OPERATOR_SEARCH_API_KEY = data.azurerm_key_vault_secret.app_backend_CGN_OPERATOR_SEARCH_API_KEY_PROD.value
      EUCOVIDCERT_API_URL         = "https://${data.azurerm_linux_function_app.eucovidcert.default_hostname}/api/v1"
      EUCOVIDCERT_API_KEY         = data.azurerm_key_vault_secret.fn_eucovidcert_API_KEY_APPBACKEND.value
      APP_MESSAGES_API_KEY        = data.azurerm_key_vault_secret.app_backend_APP_MESSAGES_API_KEY.value
      LOLLIPOP_API_URL            = "https://${data.azurerm_linux_function_app.lollipop_function.default_hostname}"
      LOLLIPOP_API_KEY            = data.azurerm_key_vault_secret.app_backend_LOLLIPOP_ITN_API_KEY.value
      TRIAL_SYSTEM_API_URL        = "https://ts-p-itn-api-func-01.azurewebsites.net" # PROD-TRIAL subscription
      TRIAL_SYSTEM_API_KEY        = data.azurerm_key_vault_secret.app_backend_TRIAL_SYSTEM_API_KEY.value
      IO_WALLET_API_URL           = "https://io-p-itn-wallet-user-func-01.azurewebsites.net"
      IO_WALLET_API_KEY           = data.azurerm_key_vault_secret.app_backend_IO_WALLET_API_KEY.value

      // EXPOSED API
      API_BASE_PATH                     = "/api/v1"
      CGN_API_BASE_PATH                 = "/api/v1/cgn"
      CGN_OPERATOR_SEARCH_API_BASE_PATH = "/api/v1/cgn/operator-search"
      EUCOVIDCERT_API_BASE_PATH         = "/api/v1/eucovidcert"
      MIT_VOUCHER_API_BASE_PATH         = "/api/v1/mitvoucher/auth"
      IO_SIGN_API_BASE_PATH             = "/api/v1/sign"
      LOLLIPOP_API_BASE_PATH            = "/api/v1"
      TRIAL_SYSTEM_API_BASE_PATH        = "/api/v1"
      IO_WALLET_API_BASE_PATH           = "/api/v1/wallet"

      // REDIS
      REDIS_URL      = data.azurerm_redis_cache.redis_common.hostname
      REDIS_PORT     = data.azurerm_redis_cache.redis_common.ssl_port
      REDIS_PASSWORD = data.azurerm_redis_cache.redis_common.primary_access_key

      // PUSH NOTIFICATIONS
      PRE_SHARED_KEY               = data.azurerm_key_vault_secret.app_backend_PRE_SHARED_KEY.value
      ALLOW_NOTIFY_IP_SOURCE_RANGE = "127.0.0.0/0"

      // LOCK / UNLOCK SESSION ENDPOINTS
      ALLOW_SESSION_HANDLER_IP_SOURCE_RANGE = data.azurerm_subnet.apim.address_prefixes[0]

      // PAGOPA
      PAGOPA_API_URL_PROD = "https://api.platform.pagopa.it/checkout/auth/payments/v1"
      PAGOPA_API_URL_TEST = "https://api.uat.platform.pagopa.it/checkout/auth/payments/v1"
      PAGOPA_API_KEY_PROD = data.azurerm_key_vault_secret.app_backend_PAGOPA_API_KEY_PROD.value
      PAGOPA_API_KEY_UAT  = data.azurerm_key_vault_secret.app_backend_PAGOPA_API_KEY_UAT.value

      // MYPORTAL
      MYPORTAL_BASE_PATH             = "/myportal/api/v1"
      ALLOW_MYPORTAL_IP_SOURCE_RANGE = data.azurerm_key_vault_secret.app_backend_ALLOW_MYPORTAL_IP_SOURCE_RANGE.value

      // MIT_VOUCHER JWT
      JWT_MIT_VOUCHER_TOKEN_ISSUER         = "app-backend.io.italia.it"
      JWT_MIT_VOUCHER_TOKEN_EXPIRATION     = 1200
      JWT_MIT_VOUCHER_TOKEN_PRIVATE_ES_KEY = data.azurerm_key_vault_secret.app_backend_JWT_MIT_VOUCHER_TOKEN_PRIVATE_ES_KEY.value
      JWT_MIT_VOUCHER_TOKEN_AUDIENCE       = data.azurerm_key_vault_secret.app_backend_JWT_MIT_VOUCHER_TOKEN_AUDIENCE.value

      // BPD
      JWT_SUPPORT_TOKEN_PRIVATE_RSA_KEY = data.azurerm_key_vault_secret.app_backend_JWT_SUPPORT_TOKEN_PRIVATE_RSA_KEY.value

      NOTIFICATIONS_QUEUE_NAME                = local.storage_account_notifications_queue_push_notifications
      NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.notifications.primary_connection_string

      PUSH_NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.push_notifications_storage.primary_connection_string
      PUSH_NOTIFICATIONS_QUEUE_NAME                = local.storage_account_notifications_queue_push_notifications

      LOCKED_PROFILES_STORAGE_CONNECTION_STRING = module.locked_profiles_storage.primary_connection_string
      LOCKED_PROFILES_TABLE_NAME                = azurerm_storage_table.locked_profiles.name

      // Feature flags
      FF_BONUS_ENABLED           = 1
      FF_CGN_ENABLED             = 1
      FF_EUCOVIDCERT_ENABLED     = 1
      FF_MIT_VOUCHER_ENABLED     = 1
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
      PN_SERVICE_ID = var.pn_service_id

      // Remote content configuration id of PN
      PN_CONFIGURATION_ID = var.pn_remote_config_id

      // Service ID IO-SIGN
      IO_SIGN_SERVICE_ID = var.io_sign_service_id

      // IO Wallet TRIAL ID
      IO_WALLET_TRIAL_ID = var.io_wallet_trial_id

      // PN Service Activation
      PN_ACTIVATION_BASE_PATH = "/api/v1/pn"
      PN_API_KEY              = data.azurerm_key_vault_secret.app_backend_PN_API_KEY_PROD.value
      PN_API_KEY_UAT          = data.azurerm_key_vault_secret.app_backend_PN_API_KEY_UAT_V2.value
      PN_API_URL              = local.pn_api_url_prod
      PN_API_URL_UAT          = var.pn_test_endpoint

      // Third Party Services
      THIRD_PARTY_CONFIG_LIST = jsonencode([
        # Piattaforma Notifiche
        {
          serviceId          = var.pn_service_id,
          schemaKind         = "PN",
          jsonSchema         = "unused",
          isLollipopEnabled  = "true",
          disableLollipopFor = split(",", local.test_users_light),
          prodEnvironment = {
            baseUrl = local.pn_api_url_prod,
            detailsAuthentication = {
              type            = "API_KEY",
              header_key_name = "x-api-key",
              key             = data.azurerm_key_vault_secret.app_backend_PN_API_KEY_PROD.value
            }
          },
          testEnvironment = {
            testUsers = split(",", local.test_users_light),
            baseUrl   = var.pn_test_endpoint,
            detailsAuthentication = {
              type            = "API_KEY",
              header_key_name = "x-api-key",
              key             = data.azurerm_key_vault_secret.app_backend_PN_API_KEY_UAT_V2.value
            }
          }
        },
        # Firma con IO (io-sign)
        {
          serviceId          = var.io_sign_service_id,
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
          serviceId          = var.io_receipt_service_test_id,
          schemaKind         = "ReceiptService",
          jsonSchema         = "unused",
          isLollipopEnabled  = "false",
          disableLollipopFor = [],
          testEnvironment = {
            testUsers = [],
            baseUrl   = var.io_receipt_service_test_url,
            detailsAuthentication = {
              type            = "API_KEY",
              header_key_name = "Ocp-Apim-Subscription-Key",
              key             = data.azurerm_key_vault_secret.app_backend_RECEIPT_SERVICE_TEST_API_KEY.value
            }
          }
        },
        # Receipt Service PROD
        {
          serviceId          = var.io_receipt_service_id,
          schemaKind         = "ReceiptService",
          jsonSchema         = "unused",
          isLollipopEnabled  = "false",
          disableLollipopFor = [],
          prodEnvironment = {
            baseUrl = var.io_receipt_service_url,
            detailsAuthentication = {
              type            = "API_KEY",
              header_key_name = "Ocp-Apim-Subscription-Key",
              key             = data.azurerm_key_vault_secret.app_backend_RECEIPT_SERVICE_API_KEY.value
            }
          }
        },
        # Mock Service
        {
          serviceId          = var.third_party_mock_service_id,
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
      LOLLIPOP_REVOKE_QUEUE_NAME                = var.citizen_auth_revoke_queue_name

      // UNIQUE EMAIL ENFORCEMENT
      FF_UNIQUE_EMAIL_ENFORCEMENT    = "ALL"
      UNIQUE_EMAIL_ENFORCEMENT_USERS = join(",", [data.azurerm_key_vault_secret.app_backend_UNIQUE_EMAIL_ENFORCEMENT_USER.value, local.test_users_unique_email_test[0]])

      // DEPRECATED APP SETTINGS
      // The following variables must be removed after a update
      // of the io-backend configuration, because they are required to start
      // the application.
      BONUS_API_BASE_PATH = "/api/v1"
      BONUS_API_URL       = "to-remove"
      BONUS_API_KEY       = "to-remove"

      // Services App Backend
      SERVICES_APP_BACKEND_BASE_PATH     = "/api/v2"
      SERVICES_APP_BACKEND_API_URL       = "https://${data.azurerm_linux_function_app.services_app_backend_function_app.default_hostname}"
      SERVICES_APP_BACKEND_API_BASE_PATH = "/api/v1"
    }
    app_settings = {
      IS_APPBACKENDLI = "false"
      // FUNCTIONS
      API_URL              = "https://${data.azurerm_linux_function_app.function_app[1].default_hostname}/api/v1"
      APP_MESSAGES_API_URL = format("https://io-p-itn-msgs-citizen-func-%02.0f.azurewebsites.net/api/v1", var.index)
    }
    app_settings_li = {
      IS_APPBACKENDLI = "true"
      // FUNCTIONS
      API_URL              = "https://${data.azurerm_linux_function_app.function_app[1].default_hostname}/api/v1" # not used
      APP_MESSAGES_API_URL = "https://io-p-itn-msgs-citizen-func-01.azurewebsites.net/api/v1"                     # not used
    }
  }

  webtest = {
      path        = "/info",
      http_status = 200,
    }

  pn_api_url_prod = "https://api-io.notifichedigitali.it"

  autoscale_profiles = [
    {
      name = "{\"name\":\"default\",\"for\":\"evening\"}",

      recurrence = {
        hours   = 22
        minutes = 59
      }

      capacity = {
        default = var.app_backend_autoscale_default + 1
        minimum = var.app_backend_autoscale_minimum + 1
        maximum = var.app_backend_autoscale_maximum
      }
    },
    {
      name = "{\"name\":\"default\",\"for\":\"night\"}",

      recurrence = {
        hours   = 5
        minutes = 0
      }

      capacity = {
        default = var.app_backend_autoscale_default + 1
        minimum = var.app_backend_autoscale_minimum + 1
        maximum = var.app_backend_autoscale_maximum
      }
    },
    {
      name = "evening"

      recurrence = {
        hours   = 19
        minutes = 30
      }

      capacity = {
        default = var.app_backend_autoscale_default + 2
        minimum = var.app_backend_autoscale_minimum + 2
        maximum = var.app_backend_autoscale_maximum
      }
    },
    {
      name = "night"

      recurrence = {
        hours   = 23
        minutes = 0
      }

      capacity = {
        default = var.app_backend_autoscale_default
        minimum = var.app_backend_autoscale_minimum
        maximum = var.app_backend_autoscale_maximum
      }
    }
  ]
}