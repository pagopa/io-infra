locals {
  project            = "${var.prefix}-${var.env_short}"
  vnet_common_name   = format("%s-vnet-common", local.project)
  rg_common_name     = format("%s-rg-common", local.project)
  rg_internal_name   = format("%s-rg-internal", local.project)
  rg_assets_cdn_name = format("%s-assets-cdn-rg", local.project)

  apim_itn_name                  = "${var.project_itn}-apim-01"
  common_resource_group_name_itn = "${var.project_itn}-common-rg-01"
}

locals {
  function_admin = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      NODE_ENV                       = "production"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4

      # DNS configuration to use private endpoint
      WEBSITE_DNS_SERVER = "168.63.129.16"

      COSMOSDB_NAME              = "db"
      COSMOSDB_URI               = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY               = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOSDB_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_api.endpoint, data.azurerm_cosmosdb_account.cosmos_api.primary_key)

      APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.application_insights.instrumentation_key

      StorageConnection = data.azurerm_storage_account.storage_api.primary_connection_string

      AssetsStorageConnection = data.azurerm_storage_account.assets_cdn.primary_connection_string

      AZURE_APIM                = "io-p-itn-apim-01"
      AZURE_APIM_HOST           = var.apim_hostname_api_internal
      AZURE_APIM_RESOURCE_GROUP = "io-p-itn-common-rg-01"

      MESSAGE_CONTAINER_NAME           = var.message_content_container_name
      UserDataArchiveStorageConnection = module.user_data_download_storage_account.primary_connection_string
      USER_DATA_CONTAINER_NAME         = "user-data-download"

      PUBLIC_API_URL           = var.service_api_url
      PUBLIC_DOWNLOAD_BASE_URL = "https://${data.azurerm_storage_account.itnuserdatadownload.primary_blob_host}/user-data-download"


      UserDataBackupStorageConnection = module.user_data_backups_storage_account.primary_connection_string
      USER_DATA_BACKUP_CONTAINER_NAME = "user-data-backup"
      USER_DATA_DELETE_DELAY_DAYS     = 6
      FF_ENABLE_USER_DATA_DELETE      = 1

      MAIL_FROM = "IO - l'app dei servizi pubblici <no-reply@io.italia.it>"

      SUBSCRIPTIONS_FEED_TABLE          = "SubscriptionsFeedByDay"
      SubscriptionFeedStorageConnection = data.azurerm_storage_account.storage_api.primary_connection_string

      // table for saving failed user data processing requests
      FAILED_USER_DATA_PROCESSING_TABLE         = "FailedUserDataProcessing"
      FailedUserDataProcessingStorageConnection = data.azurerm_storage_account.storage_api.primary_connection_string

      # SECRETS
      LOGOS_URL = data.azurerm_key_vault_secret.fn_admin_ASSETS_URL.value

      AZURE_SUBSCRIPTION_ID = data.azurerm_key_vault_secret.fn_admin_AZURE_SUBSCRIPTION_ID.value

      SERVICE_PRINCIPAL_CLIENT_ID = data.azurerm_key_vault_secret.ad_APPCLIENT_APIM_ID.value
      SERVICE_PRINCIPAL_SECRET    = data.azurerm_key_vault_secret.ad_APPCLIENT_APIM_SECRET.value
      SERVICE_PRINCIPAL_TENANT_ID = data.azurerm_key_vault_secret.common_AZURE_TENANT_ID.value

      PUBLIC_API_KEY = data.azurerm_key_vault_secret.apim_IO_GDPR_SERVICE_KEY.value

      SESSION_MANAGER_INTERNAL_API_URL = "https://${data.azurerm_linux_function_app.session_manager_internal.default_hostname}"
      SESSION_MANAGER_INTERNAL_API_KEY = data.azurerm_key_vault_secret.fn_admin_SESSION_MANAGER_INTERNAL_KEY.value

      __DISABLED__SENDGRID_API_KEY = data.azurerm_key_vault_secret.common_SENDGRID_APIKEY.value
      MAILUP_USERNAME              = data.azurerm_key_vault_secret.common_MAILUP_USERNAME.value
      MAILUP_SECRET                = data.azurerm_key_vault_secret.common_MAILUP_SECRET.value

      # UNIQUE EMAIL ENFORCEMENT
      CitizenAuthStorageConnection = data.azurerm_storage_account.auth_maintenance_storage.primary_connection_string
      SanitizeUserProfileQueueName = "profiles-to-sanitize-01"

      # Locked Profile Storage
      LOCKED_PROFILES_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.locked_profiles_storage.primary_connection_string
      LOCKED_PROFILES_TABLE_NAME                = var.function_admin_locked_profiles_table_name

      PROFILE_EMAILS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.citizen_auth_common.primary_connection_string
      PROFILE_EMAILS_TABLE_NAME                = "profileEmails"

      # Instant delete
      INSTANT_DELETE_ENABLED_USERS = join(",", [data.azurerm_key_vault_secret.fn_admin_INSTANT_DELETE_ENABLED_USERS.value, module.tests.users.all])

      # Temporany
      IOPSTLOGS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.logs02.primary_connection_string,
      LOG_RSA_PK                          = trimspace(data.azurerm_key_vault_secret.fn_app_KEY_SPIDLOGS_PRIV.value),

      IOWEBLOGS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.ioweb_spid_logs_storage.primary_connection_string
    }
  }
}
