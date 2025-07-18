locals {
  resource_group_name_common = "${var.project}-rg-common"
  vnet_name_common           = "${var.project}-vnet-common"

  function_subscriptionmigrations = {
    app_settings = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      // connection to CosmosDB
      COSMOSDB_CONNECTIONSTRING          = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_api.endpoint, data.azurerm_cosmosdb_account.cosmos_api.primary_key),
      COSMOSDB_KEY                       = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOSDB_NAME                      = "db",
      COSMOSDB_SERVICES_COLLECTION       = "services",
      COSMOSDB_SERVICES_LEASE_COLLECTION = "services-subsmigrations-leases-002",
      COSMOSDB_URI                       = data.azurerm_cosmosdb_account.cosmos_api.endpoint

      // connection to APIM
      APIM_RESOURCE_GROUP  = "io-p-itn-common-rg-01"
      APIM_SERVICE_NAME    = "io-p-itn-apim-01"
      APIM_SUBSCRIPTION_ID = data.azurerm_subscription.current.subscription_id

      // connection to PostgresSQL
      DB_HOST         = var.subsmigrations_db_data.host
      DB_PORT         = 5432
      DB_IDLE_TIMEOUT = 30000 // milliseconds
      DB_NAME         = "db"
      DB_SCHEMA       = "SelfcareIOSubscriptionMigrations"
      DB_TABLE        = "migrations"
      DB_USER         = "${var.subsmigrations_db_data.username}"
      DB_PASSWORD     = var.subsmigrations_db_data.password

      // job queues
      QUEUE_ADD_SERVICE_TO_MIGRATIONS    = "add-service-jobs"               // when a service change is accepted to be processed into migration log
      QUEUE_ALL_SUBSCRIPTIONS_TO_MIGRATE = "migrate-all-subscriptions-jobs" // when a migration is requested for all subscriptions
      QUEUE_SUBSCRIPTION_TO_MIGRATE      = "migrate-one-subscription-jobs"  // when a subscription is requested to migrate its ownership

      WEBSITE_DNS_SERVER = "168.63.129.16"
    }
  }

  app-devportal-be = {
    app_settings = {
      WEBSITE_RUN_FROM_PACKAGE = "1"

      APPINSIGHTS_INSTRUMENTATIONKEY = var.app_insights_key

      LOG_LEVEL = "info"

      IDP = "azure-ad"

      SANDBOX_FISCAL_CODE = data.azurerm_key_vault_secret.devportal_io_sandbox_fiscal_code.value
      LOGO_URL            = "https://assets.cdn.io.pagopa.it/logos"

      # Fn-Admin connection
      ADMIN_API_URL = "https://${var.apim_hostname_api_app_internal}"
      ADMIN_API_KEY = data.azurerm_key_vault_secret.devportal_apim_io_service_key.value

      # Apim connection
      APIM_PRODUCT_NAME     = "io-services-api"
      APIM_USER_GROUPS      = "apilimitedmessagewrite,apiinforead,apimessageread,apilimitedprofileread"
      ARM_APIM              = "io-p-itn-apim-01"
      ARM_RESOURCE_GROUP    = "io-p-itn-common-rg-01"
      ARM_SUBSCRIPTION_ID   = data.azurerm_subscription.current.subscription_id
      ARM_TENANT_ID         = data.azurerm_client_config.current.tenant_id
      USE_SERVICE_PRINCIPAL = "0"
      # devportal configs
      CLIENT_NAME                = "io-p-developer-portal-app"
      POLICY_NAME                = "B2C_1_SignUpInSecure"
      RESET_PASSWORD_POLICY_NAME = "B2C_1_SignUpInSecure" # Then new userflow handles sign up/sign in and password reset, no need for a dedicate password reset policy anymore
      POST_LOGIN_URL             = "https://${var.devportal_frontend_hostname}"
      POST_LOGOUT_URL            = "https://${var.devportal_frontend_hostname}"
      REPLY_URL                  = "https://${var.devportal_frontend_hostname}"
      TENANT_NAME                = "agidweb"
      CLIENT_ID                  = data.azurerm_key_vault_secret.devportal_client_id.value
      CLIENT_SECRET              = data.azurerm_key_vault_secret.devportal_client_secret.value
      COOKIE_IV                  = data.azurerm_key_vault_secret.devportal_cookie_iv.value
      COOKIE_KEY                 = data.azurerm_key_vault_secret.devportal_cookie_key.value

      # JIRA integration for Service review workflow
      JIRA_USERNAME              = "github-bot@pagopa.it"
      JIRA_NAMESPACE_URL         = "https://pagopa.atlassian.net"
      JIRA_BOARD                 = "IES"
      JIRA_STATUS_COMPLETE       = "DONE"
      JIRA_STATUS_IN_PROGRESS    = "REVIEW"
      JIRA_STATUS_NEW            = "NEW"
      JIRA_STATUS_NEW_ID         = "11"
      JIRA_STATUS_REJECTED       = "REJECTED"
      JIRA_SERVICE_TAG_PREFIX    = "SERVICE-"
      JIRA_TRANSITION_START_ID   = "31"
      JIRA_TRANSITION_REJECT_ID  = "21"
      JIRA_TRANSITION_UPDATED_ID = "51"
      JIRA_DELEGATE_ID_FIELD     = "customfield_10087"
      JIRA_EMAIL_ID_FIELD        = "customfield_10084"
      JIRA_ORGANIZATION_ID_FIELD = "customfield_10088"
      JIRA_TOKEN                 = data.azurerm_key_vault_secret.jira_token.value

      # Request Review Legacy Queue
      REQUEST_REVIEW_LEGACY_QUEUE_CONNECTIONSTRING = data.azurerm_key_vault_secret.devportal_request_review_legacy_queue_connectionstring.value
      REQUEST_REVIEW_LEGACY_QUEUE_NAME             = "request-review-legacy"

      # Feature Flags
      #
      # List of (comma separated) APIM userId for whom we want to enable Manage Flow on Service Management.
      # All users not listed below, will not be able to get (and also create) the manage subscription.
      # The "Manage Flow" allows the use of a specific subscription (Manage Subscription) keys as API Key for Service create/update.
      # Note: The list below is for the user IDs only, not the full path APIM.id.
      # UPDATE: The new feature is that "If one of such strings is "*", we suddenly open the feature to everyone.".
      MANAGE_FLOW_ENABLE_USER_LIST = "*"

      API_SERVICES_CMS_URL       = "https://${data.azurerm_linux_function_app.itn_webapp_functions_app.default_hostname}"
      API_SERVICES_CMS_BASE_PATH = "/api/v1"
    }
  }
}
