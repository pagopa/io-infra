locals {
  project            = "${var.prefix}-${var.env_short}"
  vnet_common_name   = format("%s-vnet-common", local.project)
  rg_common_name     = format("%s-rg-common", local.project)
  rg_internal_name   = format("%s-rg-internal", local.project)
  rg_assets_cdn_name = format("%s-assets-cdn-rg", local.project)

  apim_itn_name = "${local.project}-${var.location_itn}-apim-01"
}

locals {
  function_services_01 = {
    app_settings_common = {
      NODE_ENV = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      PROCESSING_MESSAGE_CONTAINER_NAME       = "processing-messages"
      MESSAGE_CREATED_QUEUE_NAME              = "message-created"
      MESSAGE_PROCESSED_QUEUE_NAME            = "message-processed"
      NOTIFICATION_CREATED_EMAIL_QUEUE_NAME   = "notification-created-email"
      NOTIFICATION_CREATED_WEBHOOK_QUEUE_NAME = "notification-created-webhook"
      MESSAGE_CONTAINER_NAME                  = "message-content"
      SUBSCRIPTIONS_FEED_TABLE                = "SubscriptionsFeedByDay"

      INTERNAL_STORAGE_CONNECTION_STRING = module.services_storage_account-01.primary_connection_string
      APPINSIGHTS_INSTRUMENTATIONKEY     = data.azurerm_application_insights.application_insights.instrumentation_key

      COSMOSDB_NAME = "db"
      COSMOSDB_URI  = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY  = data.azurerm_cosmosdb_account.cosmos_api.primary_key

      MESSAGE_CONTENT_STORAGE_CONNECTION_STRING   = data.azurerm_storage_account.storage_api.primary_connection_string
      SUBSCRIPTION_FEED_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.storage_api.primary_connection_string

      MAIL_FROM = "IO - l'app dei servizi pubblici <no-reply@io.italia.it>"
      // we keep this while we wait for new app version to be deployed
      MAIL_FROM_DEFAULT = "IO - l'app dei servizi pubblici <no-reply@io.italia.it>"

      PAGOPA_ECOMMERCE_BASE_URL = "https://api.platform.pagopa.it/ecommerce/payment-requests-service/v1"

      IO_FUNCTIONS_ADMIN_BASE_URL       = "https://api-app.internal.io.pagopa.it"
      APIM_BASE_URL                     = "https://api-app.internal.io.pagopa.it"
      DEFAULT_SUBSCRIPTION_PRODUCT_NAME = "io-services-api"

      // setting to true all the webhook message content will be disabled
      FF_DISABLE_WEBHOOK_MESSAGE_CONTENT = "false"

      OPT_OUT_EMAIL_SWITCH_DATE = var.opt_out_email_switch_date
      FF_OPT_IN_EMAIL_ENABLED   = var.ff_opt_in_email_enabled

      # setting to allow the retrieve of the payment status from payment-updater
      FF_PAYMENT_STATUS_ENABLED = "true"
      # setting to notify message via email using the template
      FF_TEMPLATE_EMAIL = "ALL"

      // minimum app version that introduces read status opt-out
      // NOTE: right now is set to a non existing version, since it's not yet deployed
      // This way we can safely deploy fn-services without enabling ADVANCED functionalities
      MIN_APP_VERSION_WITH_READ_AUTH = "2.14.0"

      // the duration of message and message-status for those messages sent to user not registered on IO.
      TTL_FOR_USER_NOT_FOUND = "${60 * 60 * 24 * 365 * 3}" //3 years in seconds
      FEATURE_FLAG           = "CANARY"

      PN_SERVICE_ID = var.pn_service_id

      #########################
      # Secrets
      #########################
      MAILUP_USERNAME                        = data.azurerm_key_vault_secret.fn_services_mailup_username.value
      MAILUP_SECRET                          = data.azurerm_key_vault_secret.fn_services_mailup_secret.value
      WEBHOOK_CHANNEL_URL                    = data.azurerm_key_vault_secret.fn_services_webhook_channel_url.value
      SANDBOX_FISCAL_CODE                    = data.azurerm_key_vault_secret.fn_services_sandbox_fiscal_code.value
      EMAIL_NOTIFICATION_SERVICE_BLACKLIST   = data.azurerm_key_vault_secret.fn_services_email_service_blacklist_id.value
      WEBHOOK_NOTIFICATION_SERVICE_BLACKLIST = data.azurerm_key_vault_secret.fn_services_notification_service_blacklist_id.value
      IO_FUNCTIONS_ADMIN_API_TOKEN           = data.azurerm_key_vault_secret.fn_services_io_service_key.value
      APIM_SUBSCRIPTION_KEY                  = data.azurerm_key_vault_secret.fn_services_io_service_key.value
      PAGOPA_ECOMMERCE_API_KEY               = data.azurerm_key_vault_secret.fn_services_pagopa_ecommerce_api_key.value
      BETA_USERS                             = data.azurerm_key_vault_secret.fn_services_beta_users.value
      SENDING_FUNC_API_KEY                   = data.azurerm_key_vault_secret.rc_func_key.value
      SENDING_FUNC_API_URL                   = "https://${data.azurerm_linux_function_app.rf_func.default_hostname}"

    }
  }
}
