#
# SECRETS
#

data "azurerm_key_vault_secret" "fn_admin_ASSETS_URL" {
  name         = "cdn-ASSETS-URL"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_admin_AZURE_SUBSCRIPTION_ID" {
  name         = "common-AZURE-SUBSCRIPTION-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_admin_INSTANT_DELETE_ENABLED_USERS" {
  name         = "fn-admin-INSTANT-DELETE-ENABLED-USERS"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "adb2c_TENANT_NAME" {
  name         = "adb2c-TENANT-NAME"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_CLIENT_ID" {
  name         = "devportal-CLIENT-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_CLIENT_SECRET" {
  name         = "devportal-CLIENT-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "adb2c_TOKEN_ATTRIBUTE_NAME" {
  name         = "adb2c-TOKEN-ATTRIBUTE-NAME"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "ad_APPCLIENT_APIM_ID" {
  name         = "ad-APPCLIENT-APIM-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "ad_APPCLIENT_APIM_SECRET" {
  name         = "ad-APPCLIENT-APIM-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "common_AZURE_TENANT_ID" {
  name         = "common-AZURE-TENANT-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "apim_IO_GDPR_SERVICE_KEY" {
  name         = "apim-IO-GDPR-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "common_SENDGRID_APIKEY" {
  name         = "common-SENDGRID-APIKEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

#
# STORAGE
#

data "azurerm_storage_account" "userdatadownload" {
  name                = "iopstuserdatadownload"
  resource_group_name = local.rg_internal_name
}

data "azurerm_storage_account" "userbackups" {
  name                = "iopstuserbackups"
  resource_group_name = local.rg_internal_name
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

      StorageConnection = data.azurerm_storage_account.storage_api.primary_connection_string

      AssetsStorageConnection = data.azurerm_storage_account.assets_cdn.primary_connection_string

      AZURE_APIM                = "io-p-itn-apim-01"
      AZURE_APIM_HOST           = local.apim_hostname_api_internal
      AZURE_APIM_RESOURCE_GROUP = "io-p-itn-common-rg-01"

      MESSAGE_CONTAINER_NAME = local.message_content_container_name

      UserDataArchiveStorageConnection = data.azurerm_storage_account.userdatadownload.primary_connection_string
      USER_DATA_CONTAINER_NAME         = "user-data-download"

      PUBLIC_API_URL           = local.service_api_url
      PUBLIC_DOWNLOAD_BASE_URL = "https://${data.azurerm_storage_account.userdatadownload.primary_blob_host}/user-data-download"


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
      CitizenAuthStorageConnection = data.azurerm_storage_account.citizen_auth_common.primary_connection_string
      SanitizeUserProfileQueueName = "profiles-to-sanitize"

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

# Admin resouce group
resource "azurerm_resource_group" "admin_rg" {
  name     = format("%s-admin-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host admin function
module "admin_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.52.0"
  name                                      = format("%s-admin-snet", local.project)
  address_prefixes                          = var.cidr_subnet_fnadmin
  resource_group_name                       = local.rg_common_name
  virtual_network_name                      = local.vnet_common_name
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "function_admin" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v8.52.0"

  resource_group_name     = azurerm_resource_group.admin_rg.name
  name                    = format("%s-admin-fn", local.project)
  location                = var.location
  domain                  = "IO-COMMONS"
  health_check_path       = "/info"
  system_identity_enabled = true

  node_version    = "20"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_admin_kind
    sku_tier                     = var.function_admin_sku_tier
    sku_size                     = var.function_admin_sku_size
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = false
  }

  app_settings = merge(
    local.function_admin.app_settings_common, {
      "AzureWebJobs.CheckXmlCryptoCVESamlResponse.Disabled"      = "1",
      "AzureWebJobs.CheckIoWebXmlCryptoCVESamlResponse.Disabled" = "1"
    }
  )

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 0,
  }

  subnet_id = module.admin_snet.id

  allowed_subnets = [
    module.admin_snet.id,
    data.azurerm_subnet.apim_itn_snet.id,
    data.azurerm_subnet.gh_runner.id
  ]

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  client_certificate_mode = "Required"
  sticky_app_setting_names = [
    "AzureWebJobs.UserDataProcessingTrigger.Disabled",
    "AzureWebJobs.SanitizeProfileEmail.Disabled",
    "AzureWebJobs.CheckXmlCryptoCVESamlResponse.Disabled",
    "AzureWebJobs.CheckIoWebXmlCryptoCVESamlResponse.Disabled"
  ]

  tags = var.tags
}

module "function_admin_staging_slot" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v8.52.0"

  name                    = "staging"
  location                = var.location
  resource_group_name     = azurerm_resource_group.admin_rg.name
  function_app_id         = module.function_admin.id
  health_check_path       = "/info"
  system_identity_enabled = true

  storage_account_name               = module.function_admin.storage_account.name
  storage_account_access_key         = module.function_admin.storage_account.primary_access_key
  internal_storage_connection_string = module.function_admin.storage_account_internal_function.primary_connection_string

  node_version                             = "20"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_admin.app_settings_common, {
      # Disabled CosmosDB Trigger Activity on slot
      "AzureWebJobs.UserDataProcessingTrigger.Disabled"          = "1",
      "AzureWebJobs.SanitizeProfileEmail.Disabled"               = "1",
      "AzureWebJobs.CheckXmlCryptoCVESamlResponse.Disabled"      = "1",
      "AzureWebJobs.CheckIoWebXmlCryptoCVESamlResponse.Disabled" = "1"
    }
  )

  subnet_id = module.admin_snet.id

  allowed_subnets = [
    module.admin_snet.id,
    data.azurerm_subnet.azdoa_snet.id,
    data.azurerm_subnet.apim_itn_snet.id,
    data.azurerm_subnet.gh_runner.id
  ]

  tags = var.tags
}

// ----------------------------------------------------
// Alerts
// ----------------------------------------------------
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert_failed_delete_procedure" {
  enabled             = true
  name                = "[IO-AUTH | ${module.function_admin.name}] Found one or more failed DELETE procedures"
  resource_group_name = azurerm_resource_group.admin_rg.name
  scopes              = [data.azurerm_application_insights.application_insights.id]
  description         = <<EOT
    Found one or more failed DELETE procedures.
    Check ${local.function_admin.app_settings_common.FAILED_USER_DATA_PROCESSING_TABLE} table in
    ${data.azurerm_storage_account.storage_api.name} storage account for more details
    EOT

  severity                = 1
  auto_mitigation_enabled = false
  location                = azurerm_resource_group.admin_rg.location

  // check once every day(evaluation_frequency)
  // on the last 24 hours of data(window_duration)
  evaluation_frequency = "P1D"
  window_duration      = "P1D"

  criteria {
    query                   = <<-QUERY
exceptions
| where cloud_RoleName == "${module.function_admin.name}"
| where customDimensions.name startswith "user.data.delete"
    QUERY
    operator                = "GreaterThanOrEqual"
    time_aggregation_method = "Count"
    threshold               = 1
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  # Action groups for alerts
  action {
    action_groups = [data.azurerm_monitor_action_group.io_auth_error_action_group.id]
  }

  tags = var.tags
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert_failed_download_procedure" {
  enabled             = true
  name                = "[IO-AUTH | ${module.function_admin.name}] Found one or more failed DOWNLOAD procedures"
  resource_group_name = azurerm_resource_group.admin_rg.name
  scopes              = [data.azurerm_application_insights.application_insights.id]
  description         = <<EOT
    Found one or more failed DOWNLOAD procedures.
    Check ${local.function_admin.app_settings_common.FAILED_USER_DATA_PROCESSING_TABLE} table in
    ${data.azurerm_storage_account.storage_api.name} storage account for more details
    EOT

  severity                = 1
  auto_mitigation_enabled = false
  location                = azurerm_resource_group.admin_rg.location

  // check once every day(evaluation_frequency)
  // on the last 24 hours of data(window_duration)
  evaluation_frequency = "P1D"
  window_duration      = "P1D"

  criteria {
    query                   = <<-QUERY
exceptions
| where cloud_RoleName == "${module.function_admin.name}"
| where customDimensions.name startswith "user.data.download"
    QUERY
    operator                = "GreaterThanOrEqual"
    time_aggregation_method = "Count"
    threshold               = 1
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  # Action groups for alerts
  action {
    action_groups = [data.azurerm_monitor_action_group.io_auth_error_action_group.id]
  }

  tags = var.tags
}
// -----------------------------------------------------

resource "azurerm_monitor_autoscale_setting" "function_admin" {
  name                = format("%s-autoscale", module.function_admin.name)
  resource_group_name = azurerm_resource_group.admin_rg.name
  location            = var.location
  target_resource_id  = module.function_admin.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_admin_autoscale_default
      minimum = var.function_admin_autoscale_minimum
      maximum = var.function_admin_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_admin.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3000
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
        metric_resource_id       = module.function_admin.app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 45
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
        metric_resource_id       = module.function_admin.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_admin.app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 30
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }
  }
}

# Role assignments
resource "azurerm_role_assignment" "function_admin_apim_itn" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_itn_api.id
  principal_id         = module.function_admin.system_identity_principal
}

resource "azurerm_role_assignment" "function_admin_slot_apim_itn" {
  role_definition_name = "PagoPA API Management Operator App"
  scope                = data.azurerm_api_management.apim_itn_api.id
  principal_id         = module.function_admin_staging_slot.system_identity_principal
}
