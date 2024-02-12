### Common resources

locals {
  app_backend = {
    app_command_line = "npm run start"
    app_settings_common = {
      # No downtime on slots swap
      WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
      WEBSITE_RUN_FROM_PACKAGE                        = "1"
      WEBSITE_DNS_SERVER                              = "168.63.129.16"

      APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key

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
      SAML_CERT                              = trimspace(data.azurerm_key_vault_secret.app_backend_SAML_CERT.value)
      SAML_KEY                               = trimspace(data.azurerm_key_vault_secret.app_backend_SAML_KEY.value)
      SAML_LOGOUT_CALLBACK_URL               = "https://app-backend.io.italia.it/slo"
      SAML_ISSUER                            = "https://app-backend.io.italia.it"
      SAML_ATTRIBUTE_CONSUMING_SERVICE_INDEX = "0"
      SAML_ACCEPTED_CLOCK_SKEW_MS            = "5000"
      # IDP_METADATA_URL                       = "https://registry.SPID.gov.it/metadata/idp/spid-entities-idps.xml"
      IDP_METADATA_URL                      = "https://api.is.eng.pagopa.it/idp-keys/spid/latest" # PagoPA internal cache
      IDP_METADATA_REFRESH_INTERVAL_SECONDS = "864000"                                            # 10 days

      // CIE
      # CIE_METADATA_URL = "https://idserver.servizicie.interno.gov.it:443/idp/shibboleth"
      CIE_METADATA_URL = "https://api.is.eng.pagopa.it/idp-keys/cie/latest" # PagoPA internal cache

      // CIE Test env
      ALLOWED_CIE_TEST_FISCAL_CODES = data.azurerm_key_vault_secret.app_backend_ALLOWED_CIE_TEST_FISCAL_CODES.value
      CIE_TEST_METADATA_URL         = "https://collaudo.idserver.servizicie.interno.gov.it/idp/shibboleth"


      // AUTHENTICATION
      AUTHENTICATION_BASE_PATH  = ""
      TOKEN_DURATION_IN_SECONDS = "2592000"

      LV_TOKEN_DURATION_IN_SECONDS = "900"

      // FUNCTIONS
      API_KEY                     = data.azurerm_key_vault_secret.app_backend_API_KEY.value
      BONUS_API_URL               = "http://${data.azurerm_function_app.fnapp_bonus.default_hostname}/api/v1"
      BONUS_API_KEY               = data.azurerm_key_vault_secret.app_backend_BONUS_API_KEY.value
      CGN_API_URL                 = "https://${module.function_cgn.default_hostname}"
      CGN_API_KEY                 = data.azurerm_key_vault_secret.app_backend_CGN_API_KEY.value
      IO_SIGN_API_URL             = "https://io-p-sign-user-func.azurewebsites.net"
      IO_SIGN_API_KEY             = data.azurerm_key_vault_secret.app_backend_IO_SIGN_API_KEY.value
      CGN_OPERATOR_SEARCH_API_URL = "https://cgnonboardingportal-p-op.azurewebsites.net" # prod subscription
      CGN_OPERATOR_SEARCH_API_KEY = data.azurerm_key_vault_secret.app_backend_CGN_OPERATOR_SEARCH_API_KEY_PROD.value
      EUCOVIDCERT_API_URL         = "https://${module.function_eucovidcert.default_hostname}/api/v1"
      EUCOVIDCERT_API_KEY         = data.azurerm_key_vault_secret.fn_eucovidcert_API_KEY_APPBACKEND.value
      APP_MESSAGES_API_KEY        = data.azurerm_key_vault_secret.app_backend_APP_MESSAGES_API_KEY.value
      LOLLIPOP_API_URL            = "https://io-p-weu-lollipop-fn.azurewebsites.net"
      LOLLIPOP_API_KEY            = data.azurerm_key_vault_secret.app_backend_LOLLIPOP_API_KEY.value
      FAST_LOGIN_API_URL          = "https://io-p-weu-fast-login-fn.azurewebsites.net"
      FAST_LOGIN_API_KEY          = data.azurerm_key_vault_secret.app_backend_FAST_LOGIN_API_KEY.value


      // EXPOSED API
      API_BASE_PATH                     = "/api/v1"
      BONUS_API_BASE_PATH               = "/api/v1"
      CGN_API_BASE_PATH                 = "/api/v1/cgn"
      CGN_OPERATOR_SEARCH_API_BASE_PATH = "/api/v1/cgn/operator-search"
      EUCOVIDCERT_API_BASE_PATH         = "/api/v1/eucovidcert"
      MIT_VOUCHER_API_BASE_PATH         = "/api/v1/mitvoucher/auth"
      IO_SIGN_API_BASE_PATH             = "/api/v1/sign"
      LOLLIPOP_API_BASE_PATH            = "/api/v1"

      // REDIS
      REDIS_URL      = module.redis_common.hostname
      REDIS_PORT     = module.redis_common.ssl_port
      REDIS_PASSWORD = module.redis_common.primary_access_key

      // PUSH NOTIFICATIONS
      PRE_SHARED_KEY               = data.azurerm_key_vault_secret.app_backend_PRE_SHARED_KEY.value
      ALLOW_NOTIFY_IP_SOURCE_RANGE = "127.0.0.0/0"

      // LOCK / UNLOCK SESSION ENDPOINTS
      ALLOW_SESSION_HANDLER_IP_SOURCE_RANGE = module.apim_v2_snet.address_prefixes[0]

      // PAGOPA
      PAGOPA_API_URL_PROD          = "https://api.platform.pagopa.it/checkout/auth/payments/v1"
      PAGOPA_API_URL_TEST          = "https://api.uat.platform.pagopa.it/checkout/auth/payments/v1"
      PAGOPA_BASE_PATH             = "/pagopa/api/v1"
      PAGOPA_API_KEY_PROD          = data.azurerm_key_vault_secret.app_backend_PAGOPA_API_KEY_PROD.value
      PAGOPA_API_KEY_UAT           = data.azurerm_key_vault_secret.app_backend_PAGOPA_API_KEY_UAT.value
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

      // FIMS
      FIMS_BASE_PATH = "/fims/api/v1"

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

      PUSH_NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.push_notifications_storage.primary_connection_string
      PUSH_NOTIFICATIONS_QUEUE_NAME                = local.storage_account_notifications_queue_push_notifications

      LOCKED_PROFILES_STORAGE_CONNECTION_STRING = module.locked_profiles_storage.primary_connection_string
      LOCKED_PROFILES_TABLE_NAME                = azurerm_storage_table.locked_profiles.name

      // USERSLOGIN
      USERS_LOGIN_QUEUE_NAME                = local.storage_account_notifications_queue_userslogin
      USERS_LOGIN_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.logs.primary_connection_string

      // Feature flags
      FF_BONUS_ENABLED          = 1
      FF_CGN_ENABLED            = 1
      FF_EUCOVIDCERT_ENABLED    = 1
      FF_MIT_VOUCHER_ENABLED    = 1
      FF_USER_AGE_LIMIT_ENABLED = 1
      FF_IO_SIGN_ENABLED        = 1

      FF_ROUTING_PUSH_NOTIF                      = "ALL" # possible values are: BETA, CANARY, ALL, NONE
      FF_ROUTING_PUSH_NOTIF_BETA_TESTER_SHA_LIST = data.azurerm_key_vault_secret.app_backend_APP_MESSAGES_BETA_FISCAL_CODES.value
      # ~31% of users
      FF_ROUTING_PUSH_NOTIF_CANARY_SHA_USERS_REGEX = "^([(0-9)|(a-f)|(A-F)]{63}[(0-4)]{1})$"

      FF_PN_ACTIVATION_ENABLED = "1"

      // TEST LOGIN
      TEST_LOGIN_PASSWORD     = data.azurerm_key_vault_secret.app_backend_TEST_LOGIN_PASSWORD.value
      TEST_LOGIN_FISCAL_CODES = local.test_users

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

      // Service ID IO-SIGN
      IO_SIGN_SERVICE_ID = var.io_sign_service_id

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
          disableLollipopFor = split(",", local.test_users),
          prodEnvironment = {
            baseUrl = local.pn_api_url_prod,
            detailsAuthentication = {
              type            = "API_KEY",
              header_key_name = "x-api-key",
              key             = data.azurerm_key_vault_secret.app_backend_PN_API_KEY_PROD.value
            }
          },
          testEnvironment = {
            testUsers = split(",", local.test_users),
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
      LOLLIPOP_ALLOWED_USER_AGENTS              = "IO-App/2.23.0"
      LOLLIPOP_REVOKE_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.lollipop_assertions_storage.primary_connection_string
      LOLLIPOP_REVOKE_QUEUE_NAME                = var.citizen_auth_revoke_queue_name

      FF_LOLLIPOP_ENABLED = "1"

      //IOLOGIN redirect
      FF_IOLOGIN         = "BETA"
      IOLOGIN_TEST_USERS = data.azurerm_key_vault_secret.app_backend_IOLOGIN_TEST_USERS.value
      # Takes ~6,25% of users
      IOLOGIN_CANARY_USERS_REGEX = "^([(0-9)|(a-f)|(A-F)]{63}0)$"

      // UNIQUE EMAIL ENFORCEMENT
      FF_UNIQUE_EMAIL_ENFORCEMENT    = "ALL"
      UNIQUE_EMAIL_ENFORCEMENT_USERS = join(",", [data.azurerm_key_vault_secret.app_backend_UNIQUE_EMAIL_ENFORCEMENT_USER.value, local.test_users_unique_email_test[0]])

      IS_SPID_EMAIL_PERSISTENCE_ENABLED = "false"


      // FAST LOGIN
      FF_FAST_LOGIN = "ALL"
      LV_TEST_USERS = join(",", [data.azurerm_key_vault_secret.app_backend_LV_TEST_USERS.value, local.test_users])

      BACKEND_HOST = "https://${trimsuffix(azurerm_dns_a_record.api_app_io_pagopa_it.fqdn, ".")}"

      // CLOCK SKEW LOG EVENT
      HAS_CLOCK_SKEW_LOG_EVENT = "false"
    }
    app_settings_l1 = {
      IS_APPBACKENDLI = "false"
      // FUNCTIONS
      API_URL              = "https://${module.function_app[0].default_hostname}/api/v1"
      APP_MESSAGES_API_URL = "https://${module.app_messages_function[0].default_hostname}/api/v1"
    }
    app_settings_l2 = {
      IS_APPBACKENDLI = "false"
      // FUNCTIONS
      API_URL              = "https://${module.function_app[1].default_hostname}/api/v1"
      APP_MESSAGES_API_URL = "https://${module.app_messages_function[1].default_hostname}/api/v1"
    }
    app_settings_li = {
      IS_APPBACKENDLI = "true"
      // FUNCTIONS
      API_URL              = "https://${module.function_app[0].default_hostname}/api/v1"          # not used
      APP_MESSAGES_API_URL = "https://${module.app_messages_function[0].default_hostname}/api/v1" # not used
    }
  }

  app_backend_test_urls = [
    {
      id          = "io-p-app-appbackendl1.azurewebsites.net"
      name        = module.appservice_app_backendl1.default_site_hostname,
      host        = module.appservice_app_backendl1.default_site_hostname,
      path        = "/info",
      http_status = 200,
    },
    {
      id          = "io-p-app-appbackendl2.azurewebsites.net"
      name        = module.appservice_app_backendl2.default_site_hostname,
      host        = module.appservice_app_backendl2.default_site_hostname,
      path        = "/info",
      http_status = 200,
    },
    {
      id          = "io-p-app-appbackendli.azurewebsites.net"
      name        = module.appservice_app_backendli.default_site_hostname,
      host        = module.appservice_app_backendli.default_site_hostname,
      path        = "/info",
      http_status = 200,
    },
  ]

  pn_api_url_prod = "https://api-io.notifichedigitali.it"

}

resource "azurerm_resource_group" "rg_linux" {
  name     = format("%s-rg-linux", local.project)
  location = var.location

  tags = var.tags
}

## key vault

data "azurerm_key_vault_secret" "app_backend_SAML_CERT" {
  name         = "appbackend-SAML-CERT"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_SAML_KEY" {
  name         = "appbackend-SAML-KEY"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_API_KEY" {
  name         = "funcapp-KEY-APPBACKEND"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_BONUS_API_KEY" {
  name         = "funcbonus-KEY-APPBACKEND"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_CGN_API_KEY" {
  name         = "funccgn-KEY-APPBACKEND"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_IO_SIGN_API_KEY" {
  name         = "funciosign-KEY-APPBACKEND"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_CGN_OPERATOR_SEARCH_API_KEY_PROD" {
  name         = "funccgnoperatorsearch-KEY-PROD-APPBACKEND"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_CGN_OPERATOR_SEARCH_API_KEY_UAT" {
  name         = "funccgnoperatorsearch-KEY-UAT-APPBACKEND"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOW_PAGOPA_IP_SOURCE_RANGE" {
  name         = "appbackend-ALLOW-PAGOPA-IP-SOURCE-RANGE"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PAGOPA_API_KEY_PROD" {
  name         = "appbackend-PAGOPA-API-KEY-PROD-PRIMARY"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PAGOPA_API_KEY_UAT" {
  name         = "appbackend-PAGOPA-API-KEY-UAT-PRIMARY"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_TEST_LOGIN_PASSWORD" {
  name         = "appbackend-TEST-LOGIN-PASSWORD"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOW_MYPORTAL_IP_SOURCE_RANGE" {
  name         = "appbackend-ALLOW-MYPORTAL-IP-SOURCE-RANGE"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOW_BPD_IP_SOURCE_RANGE" {
  name         = "appbackend-ALLOW-BPD-IP-SOURCE-RANGE"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_JWT_SUPPORT_TOKEN_PRIVATE_RSA_KEY" {
  name         = "appbackend-JWT-SUPPORT-TOKEN-PRIVATE-RSA-KEY"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_TEST_CGN_FISCAL_CODES" {
  name         = "appbackend-TEST-CGN-FISCAL-CODES"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_JWT_MIT_VOUCHER_TOKEN_PRIVATE_ES_KEY" {
  name         = "appbackend-mitvoucher-JWT-PRIVATE-ES-KEY"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_JWT_MIT_VOUCHER_TOKEN_AUDIENCE" {
  name         = "appbackend-mitvoucher-JWT-AUDIENCE"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOW_ZENDESK_IP_SOURCE_RANGE" {
  name         = "appbackend-ALLOW-ZENDESK-IP-SOURCE-RANGE"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_JWT_ZENDESK_SUPPORT_TOKEN_SECRET" {
  name         = "appbackend-JWT-ZENDESK-SUPPORT-TOKEN-SECRET"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PECSERVER_TOKEN_SECRET" {
  name         = "appbackend-PECSERVER-TOKEN-SECRET"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PECSERVER_ARUBA_TOKEN_SECRET" {
  name         = "appbackend-PECSERVER-ARUBA-TOKEN-SECRET"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_APP_MESSAGES_API_KEY" {
  name         = "appbackend-APP-MESSAGES-API-KEY"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_APP_MESSAGES_BETA_FISCAL_CODES" {
  name         = "appbackend-APP-MESSAGES-BETA-FISCAL-CODES"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PN_API_KEY_PROD" {
  name         = "appbackend-PN-API-KEY-PROD-ENV"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PN_API_KEY_UAT_V2" {
  name         = "appbackend-PN-API-KEY-UAT-ENV-V2"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_PN_REAL_TEST_USERS" {
  name         = "appbackend-PN-REAL-TEST-USERS"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_LOLLIPOP_API_KEY" {
  name         = "appbackend-LOLLIPOP-API-KEY"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_FAST_LOGIN_API_KEY" {
  name         = "appbackend-FAST-LOGIN-API-KEY"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_IOLOGIN_TEST_USERS" {
  name         = "appbackend-IOLOGIN-TEST-USERS"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_UNIQUE_EMAIL_ENFORCEMENT_USER" {
  name         = "appbackend-UNIQUE-EMAIL-ENFORCEMENT-USER"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_LV_TEST_USERS" {
  name         = "appbackend-LV-TEST-USERS"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_ALLOWED_CIE_TEST_FISCAL_CODES" {
  name         = "appbackend-ALLOWED-CIE-TEST-FISCAL-CODES"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_RECEIPT_SERVICE_TEST_API_KEY" {
  name         = "appbackend-RECEIPT-SERVICE-TEST-API-KEY"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "app_backend_RECEIPT_SERVICE_API_KEY" {
  name         = "appbackend-RECEIPT-SERVICE-API-KEY"
  key_vault_id = module.key_vault_common.id
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-REDIS-PASSWORD" {
  name         = "appbackend-REDIS-PASSWORD"
  value        = module.redis_common.primary_access_key
  key_vault_id = module.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-SPID-LOG-STORAGE" {
  name         = "appbackend-SPID-LOG-STORAGE"
  value        = data.azurerm_storage_account.logs.primary_connection_string
  key_vault_id = module.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-PUSH-NOTIFICATIONS-STORAGE" {
  name         = "appbackend-PUSH-NOTIFICATIONS-STORAGE"
  value        = data.azurerm_storage_account.push_notifications_storage.primary_connection_string
  key_vault_id = module.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-NORIFICATIONS-STORAGE" {
  name         = "appbackend-NORIFICATIONS-STORAGE"
  value        = data.azurerm_storage_account.notifications.primary_connection_string
  key_vault_id = module.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend-USERS-LOGIN-STORAGE" {
  name         = "appbackend-USERS-LOGIN-STORAGE"
  value        = data.azurerm_storage_account.logs.primary_connection_string
  key_vault_id = module.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend_LOLLIPOP_ASSERTIONS_STORAGE" {
  name         = "appbackend-LOLLIPOP-ASSERTIONS-STORAGE"
  value        = data.azurerm_storage_account.lollipop_assertions_storage.primary_connection_string
  key_vault_id = module.key_vault_common.id
  content_type = "string"
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "appbackend_THIRD_PARTY_CONFIG_LIST" {
  name         = "appbackend-THIRD-PARTY-CONFIG-LIST"
  value        = local.app_backend.app_settings_common.THIRD_PARTY_CONFIG_LIST
  key_vault_id = module.key_vault_common.id
  content_type = "string"
}

## app_backendl1

module "app_backendl1_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.34.3"
  name                                      = "appbackendl1"
  address_prefixes                          = var.cidr_subnet_appbackendl1
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = true

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

resource "azurerm_subnet_nat_gateway_association" "app_backendl1_snet" {
  nat_gateway_id = module.nat_gateway.id
  subnet_id      = module.app_backendl1_snet.id
}

data "azurerm_subnet" "functions_fast_login_snet" {
  name                 = format("%s-%s-fast-login-snet", local.project, var.location_short)
  virtual_network_name = module.vnet_common.name
  resource_group_name  = azurerm_resource_group.rg_common.name
}

module "appservice_app_backendl1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v7.33.0"

  # App service plan
  plan_type = "internal"
  plan_name = format("%s-plan-appappbackendl1", local.project)
  sku_name  = var.app_backend_plan_sku_size

  # App service
  name                = format("%s-app-appbackendl1", local.project)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  node_version                 = "18-lts"
  always_on                    = true
  app_command_line             = local.app_backend.app_command_line
  health_check_path            = "/ping"
  health_check_maxpingfailures = 3

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_l1,
  )

  allowed_subnets = [
    module.services_snet[0].id,
    module.services_snet[1].id,
    module.appgateway_snet.id,
    module.apim_v2_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  subnet_id        = module.app_backendl1_snet.id
  vnet_integration = true

  tags = var.tags
}

module "appservice_app_backendl1_slot_staging" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot?ref=v7.34.3"

  # App service plan
  app_service_id   = module.appservice_app_backendl1.id
  app_service_name = module.appservice_app_backendl1.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on         = true
  node_version      = "18-lts"
  app_command_line  = local.app_backend.app_command_line
  health_check_path = "/ping"

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_l1,
  )

  allowed_subnets = [
    module.azdoa_snet[0].id,
    module.services_snet[0].id,
    module.services_snet[1].id,
    module.appgateway_snet.id,
    module.apim_v2_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  subnet_id        = module.app_backendl1_snet.id
  vnet_integration = true

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "appservice_app_backendl1" {
  name                = format("%s-autoscale", module.appservice_app_backendl1.name)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location
  target_resource_id  = module.appservice_app_backendl1.plan_id

  profile {
    name = "default"

    capacity {
      default = var.app_backend_autoscale_default
      minimum = 2 # var.app_backend_autoscale_minimum
      maximum = var.app_backend_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendl1.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.appservice_app_backendl1.plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 50
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendl1.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 1000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1H"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.appservice_app_backendl1.plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 10
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1H"
      }
    }
  }
}

## app_backendl2

module "app_backendl2_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.34.3"
  name                                      = "appbackendl2"
  address_prefixes                          = var.cidr_subnet_appbackendl2
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = true

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

resource "azurerm_subnet_nat_gateway_association" "app_backendl2_snet" {
  nat_gateway_id = module.nat_gateway.id
  subnet_id      = module.app_backendl2_snet.id
}

module "appservice_app_backendl2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v7.33.0"

  # App service plan
  plan_type = "internal"
  plan_name = format("%s-plan-appappbackendl2", local.project)
  sku_name  = var.app_backend_plan_sku_size

  # App service
  name                = format("%s-app-appbackendl2", local.project)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on                    = true
  node_version                 = "18-lts"
  app_command_line             = local.app_backend.app_command_line
  health_check_path            = "/ping"
  health_check_maxpingfailures = 3

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_l2,
  )

  allowed_subnets = [
    module.services_snet[0].id,
    module.services_snet[1].id,
    module.appgateway_snet.id,
    module.apim_v2_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  subnet_id        = module.app_backendl2_snet.id
  vnet_integration = true

  tags = var.tags
}

module "appservice_app_backendl2_slot_staging" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot?ref=v7.34.3"

  # App service plan
  app_service_id   = module.appservice_app_backendl2.id
  app_service_name = module.appservice_app_backendl2.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on         = true
  node_version      = "18-lts"
  app_command_line  = local.app_backend.app_command_line
  health_check_path = "/ping"

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_l2,
  )

  allowed_subnets = [
    module.azdoa_snet[0].id,
    module.services_snet[0].id,
    module.services_snet[1].id,
    module.appgateway_snet.id,
    module.apim_v2_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  subnet_id        = module.app_backendl2_snet.id
  vnet_integration = true

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "appservice_app_backendl2" {
  name                = format("%s-autoscale", module.appservice_app_backendl2.name)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location
  target_resource_id  = module.appservice_app_backendl2.plan_id

  profile {
    name = "default"

    capacity {
      default = var.app_backend_autoscale_default
      minimum = var.app_backend_autoscale_minimum
      maximum = var.app_backend_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendl2.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.appservice_app_backendl2.plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 50
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendl2.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 1000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1H"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.appservice_app_backendl2.plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 10
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1H"
      }
    }
  }
}

## app_backendli

module "app_backendli_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.34.3"
  name                                      = "appbackendli"
  address_prefixes                          = var.cidr_subnet_appbackendli
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = true

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

resource "azurerm_subnet_nat_gateway_association" "app_backendli_snet" {
  nat_gateway_id = module.nat_gateway.id
  subnet_id      = module.app_backendli_snet.id
}

module "appservice_app_backendli" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v7.33.0"

  # App service plan
  plan_type = "internal"
  plan_name = format("%s-plan-appappbackendli", local.project)
  plan_kind = "Linux"
  sku_name  = var.app_backend_plan_sku_size

  # App service
  name                = format("%s-app-appbackendli", local.project)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on                    = true
  node_version                 = "18-lts"
  app_command_line             = local.app_backend.app_command_line
  health_check_path            = "/ping"
  health_check_maxpingfailures = 3

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_li,
  )

  allowed_subnets = [
    module.services_snet[0].id,
    module.services_snet[1].id,
    module.admin_snet.id,
    data.azurerm_subnet.functions_fast_login_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
    local.aks_ips,
  )

  subnet_id        = module.app_backendli_snet.id
  vnet_integration = true

  tags = var.tags
}

module "appservice_app_backendli_slot_staging" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot?ref=v7.34.3"

  # App service plan
  app_service_id   = module.appservice_app_backendli.id
  app_service_name = module.appservice_app_backendli.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on         = true
  node_version      = "18-lts"
  app_command_line  = local.app_backend.app_command_line
  health_check_path = "/ping"

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_li,
  )

  allowed_subnets = [
    module.azdoa_snet[0].id,
    module.services_snet[0].id,
    module.services_snet[1].id,
    module.admin_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  subnet_id        = module.app_backendli_snet.id
  vnet_integration = true

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "appservice_app_backendli" {
  name                = format("%s-autoscale", module.appservice_app_backendli.name)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location
  target_resource_id  = module.appservice_app_backendli.plan_id

  profile {
    name = "default"

    capacity {
      default = var.app_backend_autoscale_default
      minimum = var.app_backend_autoscale_minimum
      maximum = var.app_backend_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendli.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendli.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 1000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1H"
      }
    }
  }
}

## web availabolity test
module "app_backend_web_test_api" {
  for_each = { for v in local.app_backend_test_urls : v.id => v if v != null }
  source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//application_insights_web_test_preview?ref=v7.34.3"

  subscription_id                   = data.azurerm_subscription.current.subscription_id
  name                              = format("%s-test", each.value.name)
  location                          = azurerm_resource_group.rg_common.location
  resource_group                    = azurerm_resource_group.rg_common.name
  application_insight_name          = azurerm_application_insights.application_insights.name
  request_url                       = format("https://%s%s", each.value.host, each.value.path)
  expected_http_status              = each.value.http_status
  ssl_cert_remaining_lifetime_check = 7
  application_insight_id            = azurerm_application_insights.application_insights.id

  actions = [
    {
      action_group_id = azurerm_monitor_action_group.error_action_group.id,
    }
  ]
}

# -----------------------------------------------
# Alerts
# -----------------------------------------------

data "azurerm_linux_web_app" "app_backend_app_services" {
  for_each            = toset(var.app_backend_names)
  name                = "${local.project}-app-${each.value}"
  resource_group_name = azurerm_resource_group.rg_linux.name
}

resource "azurerm_monitor_metric_alert" "too_many_http_5xx" {
  for_each = { for key, name in data.azurerm_linux_web_app.app_backend_app_services : key => name }

  enabled = false

  name                = "[IO-COMMONS | ${each.value.name}] Too many 5xx"
  resource_group_name = azurerm_resource_group.rg_linux.name
  scopes              = [each.value.id]
  # TODO: add Runbook for checking errors
  description   = "Whenever the total http server errors exceeds a dynamic threashold. Runbook: ${"https://pagopa.atlassian.net"}/wiki/spaces/IC/pages/585072814/Appbackendlx+-+Too+many+errors"
  severity      = 0
  window_size   = "PT5M"
  frequency     = "PT5M"
  auto_mitigate = false

  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftwebsites
  dynamic_criteria {
    metric_namespace         = "Microsoft.Web/sites"
    metric_name              = "Http5xx"
    aggregation              = "Total"
    operator                 = "GreaterThan"
    alert_sensitivity        = "Low"
    evaluation_total_count   = 4
    evaluation_failure_count = 4
    skip_metric_validation   = false

  }

  action {
    action_group_id    = azurerm_monitor_action_group.error_action_group.id
    webhook_properties = null
  }

  tags = var.tags
}
