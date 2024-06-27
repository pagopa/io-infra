locals {
  # COMMON SETTINGS

  tags = merge(var.tags, {
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra"
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
  })

  env_short                  = "p"
  location                   = "italynorth"
  location_short             = "itn"
  instance_number            = "01"
  domain                     = "infra" # TO CHECK - "IO-COMMONS"

  project                    = "${var.prefix}-${local.env_short}"

  # To distinguish between different configurations as common/internal/cdn and italy north (regional)
  resource_groups = {
    common = {
      name = "${local.project}-rg-common"
    }
    regional = {
      name = "${local.project}-${local.location_short}-common-rg-${local.instance_number}"
    }
    internal = {
      name = "${local.project}-rg-internal"
    }
    assets_cdn = {
      name = "${local.project}-assets-cdn-rg"
    }

  }

  virtual_networks = {
    common = {
      name = "${local.project}-vnet-common"
    }
    regional = {
      name = "${local.project}-${local.location_short}-common-vnet-${local.instance_number}"
    }
  }

  # vnet_common_name           = "${local.project}-${local.location_short}-common-vnet-${local.instance_number}"
  # rg_common_name             = "${local.project}-${local.location_short}-common-rg-${local.instance_number}"
  # rg_internal_name           = "${local.project}-rg-internal"   # TO CHECK
  # rg_assets_cdn_name         = "${local.project}-assets-cdn-rg" # TO CHECK

  apim_hostname_api_internal = "api-internal.io.italia.it"

  # MESSAGES
  message_content_container_name = "message-content"

  service_api_url = "https://api-app.internal.io.pagopa.it/"

  # ------------------------------------------------ #
  # --------- Function Admin Configuration --------- #
  # ------------------------------------------------ #

  function_admin = {
    tier          = "standard"
    snet_cidr     = "10.20.15.0/26"
    cosmosdb_name = "" # TO CHECK

    # Networking
    # cidr_subnet_fnadmin = ["10.20.15.0/26"] # CHECK Changed subnet IPs from 10.0. to 10.20.

    # Specific settings
    function_admin_kind     = "Linux"
    function_admin_sku_tier = "PremiumV3"
    function_admin_sku_size = "P1v3"

    app_settings = {
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

      StorageConnection = data.azurerm_storage_account.storage_api.primary_connection_string

      AssetsStorageConnection = data.azurerm_storage_account.assets_cdn.primary_connection_string

      AZURE_APIM                = "io-p-apim-v2-api"
      AZURE_APIM_HOST           = local.apim_hostname_api_internal
      AZURE_APIM_RESOURCE_GROUP = "io-p-rg-internal"

      MESSAGE_CONTAINER_NAME = local.message_content_container_name

      UserDataArchiveStorageConnection = data.azurerm_storage_account.userdatadownload.primary_connection_string
      USER_DATA_CONTAINER_NAME         = "user-data-download"

      PUBLIC_API_URL           = local.service_api_url
      PUBLIC_DOWNLOAD_BASE_URL = "https://${data.azurerm_storage_account.userdatadownload.primary_blob_host}/user-data-download"

      SESSION_API_URL                 = "https://${data.azurerm_app_service.appservice_app_backendli.default_site_hostname}" # https://io-p-app-appbackendli.azurewebsites.net
      UserDataBackupStorageConnection = data.azurerm_storage_account.userbackups.primary_connection_string
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

      ADB2C_TENANT_ID            = data.azurerm_key_vault_secret.adb2c_TENANT_NAME.value
      ADB2C_CLIENT_ID            = data.azurerm_key_vault_secret.devportal_CLIENT_ID.value
      ADB2C_CLIENT_KEY           = data.azurerm_key_vault_secret.devportal_CLIENT_SECRET.value
      ADB2C_TOKEN_ATTRIBUTE_NAME = data.azurerm_key_vault_secret.adb2c_TOKEN_ATTRIBUTE_NAME.value

      SERVICE_PRINCIPAL_CLIENT_ID = data.azurerm_key_vault_secret.ad_APPCLIENT_APIM_ID.value
      SERVICE_PRINCIPAL_SECRET    = data.azurerm_key_vault_secret.ad_APPCLIENT_APIM_SECRET.value
      SERVICE_PRINCIPAL_TENANT_ID = data.azurerm_key_vault_secret.common_AZURE_TENANT_ID.value

      PUBLIC_API_KEY = data.azurerm_key_vault_secret.apim_IO_GDPR_SERVICE_KEY.value

      SESSION_API_KEY = data.azurerm_key_vault_secret.app_backend_PRE_SHARED_KEY.value

      __DISABLED__SENDGRID_API_KEY = data.azurerm_key_vault_secret.common_SENDGRID_APIKEY.value
      MAILUP_USERNAME              = data.azurerm_key_vault_secret.common_MAILUP_USERNAME.value
      MAILUP_SECRET                = data.azurerm_key_vault_secret.common_MAILUP_SECRET.value

      # UNIQUE EMAIL ENFORCEMENT
      CitizenAuthStorageConnection = data.azurerm_storage_account.citizen_auth_common.primary_connection_string
      SanitizeUserProfileQueueName = "profiles-to-sanitize"

      # Locked Profile Storage
      LOCKED_PROFILES_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.locked_profiles_storage.primary_connection_string
      LOCKED_PROFILES_TABLE_NAME                = var.function_admin_locked_profiles_table_name

      PROFILE_EMAILS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.citizen_auth_common.primary_connection_string
      PROFILE_EMAILS_TABLE_NAME                = "profileEmails"

      # Instant delete
      INSTANT_DELETE_ENABLED_USERS = join(",", [data.azurerm_key_vault_secret.fn_admin_INSTANT_DELETE_ENABLED_USERS.value, module.tests.test_users.all])
    }

    alert_action = [
      {
        action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
        webhook_properties = {}
      }
    ]

    autoscale_settings = {
      min     = 1
      max     = 3
      default = 1
    }
  }
}