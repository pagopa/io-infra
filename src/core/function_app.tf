#
# SECRETS
#

data "azurerm_key_vault_secret" "fn_app_MAILUP_USERNAME" {
  name         = "common-MAILUP2-USERNAME"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_app_MAILUP_SECRET" {
  name         = "common-MAILUP2-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_app_PUBLIC_API_KEY" {
  name         = "apim-IO-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_app_SPID_LOGS_PUBLIC_KEY" {
  name         = "funcapp-KEY-SPIDLOGS-PUB"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_app_AZURE_NH_ENDPOINT" {
  name         = "common-AZURE-NH-ENDPOINT"
  key_vault_id = data.azurerm_key_vault.common.id
}

# 
# STORAGE
#

data "azurerm_storage_account" "iopstapp" {
  name                = "iopstapp"
  resource_group_name = azurerm_resource_group.rg_internal.name
}

#
# APP CONFIGURATION
#

locals {
  function_app = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_VNET_ROUTE_ALL         = "1"
      WEBSITE_DNS_SERVER             = "168.63.129.16"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      COSMOSDB_NAME = "db"
      COSMOSDB_URI  = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY  = data.azurerm_cosmosdb_account.cosmos_api.primary_master_key

      MESSAGE_CONTAINER_NAME = "message-content"
      QueueStorageConnection = data.azurerm_storage_account.api.primary_connection_string

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      LogsStorageConnection      = data.azurerm_storage_account.logs.primary_connection_string
      AssetsStorageConnection    = data.azurerm_storage_account.cdnassets.primary_connection_string
      STATUS_ENDPOINT_URL        = "https://api-app.io.pagopa.it/info"
      STATUS_REFRESH_INTERVAL_MS = "300000"

      // TODO: Rename to SUBSCRIPTIONSFEEDBYDAY_TABLE_NAME
      SUBSCRIPTIONS_FEED_TABLE = "SubscriptionsFeedByDay"
      MAIL_FROM                = "IO - l'app dei servizi pubblici <no-reply@io.italia.it>"
      DPO_EMAIL_ADDRESS        = "dpo@pagopa.it"
      PUBLIC_API_URL           = "http://api-app.internal.io.pagopa.it/"
      FUNCTIONS_PUBLIC_URL     = "https://api.io.pagopa.it/public"

      // Push notifications
      AZURE_NH_HUB_NAME                       = "io-p-ntf-common"
      NOTIFICATIONS_QUEUE_NAME                = local.storage_account_notifications_queue_push_notifications
      NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.notifications.primary_connection_string

      // Service Preferences Migration Queue
      MIGRATE_SERVICES_PREFERENCES_PROFILE_QUEUE_NAME = "profile-migrate-services-preferences-from-legacy"
      FN_APP_STORAGE_CONNECTION_STRING                = data.azurerm_storage_account.iopstapp.primary_connection_string

      // Events configs
      EventsQueueStorageConnection = data.azurerm_storage_account.storage_apievents.primary_connection_string
      EventsQueueName              = "events" # reference to https://github.com/pagopa/io-infra/blob/12a2f3bffa49dab481990fccc9f2a904004862ec/src/core/storage_apievents.tf#L7

      // Disable functions
      "AzureWebJobs.StoreSpidLogs.Disabled"            = "1"
      "AzureWebJobs.HandleNHNotificationCall.Disabled" = "1"

      # Cashback welcome message
      IS_CASHBACK_ENABLED = "false"
      # Only national service
      FF_ONLY_NATIONAL_SERVICES = "true"
      # Limit the number of local services
      FF_LOCAL_SERVICES_LIMIT = "0"
      # eucovidcert configs
      FF_NEW_USERS_EUCOVIDCERT_ENABLED       = "true"
      EUCOVIDCERT_PROFILE_CREATED_QUEUE_NAME = "eucovidcert-profile-created"

      OPT_OUT_EMAIL_SWITCH_DATE = local.opt_out_email_switch_date
      FF_OPT_IN_EMAIL_ENABLED   = local.ff_opt_in_email_enabled

      VISIBLE_SERVICE_BLOB_ID = "visible-services-national.json"

      MAILUP_USERNAME      = data.azurerm_key_vault_secret.fn_app_MAILUP_USERNAME
      MAILUP_SECRET        = data.azurerm_key_vault_secret.fn_app_MAILUP_SECRET
      PUBLIC_API_KEY       = data.azurerm_key_vault_secret.fn_app_PUBLIC_API_KEY
      SPID_LOGS_PUBLIC_KEY = data.azurerm_key_vault_secret.fn_app_SPID_LOGS_PUBLIC_KEY
      AZURE_NH_ENDPOINT    = data.azurerm_key_vault_secret.fn_app_AZURE_NH_ENDPOINT
    }
    app_settings_1 = {
    }
    app_settings_2 = {
    }
  }
}

resource "azurerm_resource_group" "app_rg" {
  count    = var.app_count
  name     = format("%s-app-rg-%d", local.project, count.index + 1)
  location = var.location

  tags = var.tags
}

# Subnet to host app function
module "app_snet" {
  count                                          = var.app_count
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-app-snet-%d", local.project, count.index + 1)
  address_prefixes                               = [var.cidr_subnet_app[count.index]]
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true

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

#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "app_function" {
  count  = var.app_count
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v3.4.0"

  resource_group_name = azurerm_resource_group.app_rg[count.index].name
  name                = format("%s-app-fn-%d", local.project, count.index + 1)
  location            = var.location
  health_check_path   = "api/v1/info"

  os_type          = "linux"
  linux_fx_version = "NODE|14"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.app_function_kind
    sku_tier                     = var.app_function_sku_tier
    sku_size                     = var.app_function_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = local.function_app.app_settings_common

  subnet_id = module.app_snet[count.index].id

  allowed_subnets = [
    module.app_snet[count.index].id,
    module.app_backendl1_snet.id,
    module.app_backendl2_snet.id,
    module.app_backendli_snet.id,
  ]

  tags = var.tags
}

module "app_function_staging_slot" {
  count  = var.app_count
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v3.4.0"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.app_rg[count.index].name
  function_app_name   = module.app_function[count.index].name
  function_app_id     = module.app_function[count.index].id
  app_service_plan_id = module.app_function[count.index].app_service_plan_id
  health_check_path   = "api/v1/info"

  storage_account_name       = module.app_function[count.index].storage_account.name
  storage_account_access_key = module.app_function[count.index].storage_account.primary_access_key

  os_type                                  = "linux"
  linux_fx_version                         = "NODE|14"
  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = local.function_app.app_settings_common

  subnet_id = module.app_snet[count.index].id

  allowed_subnets = [
    module.app_snet[count.index].id,
    data.azurerm_subnet.azdoa_snet[0].id,
    module.app_backendl1_snet.id,
    module.app_backendl2_snet.id,
    module.app_backendli_snet.id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "app_function" {
  count               = var.app_count
  name                = format("%s-autoscale", module.app_function[count.index].name)
  resource_group_name = azurerm_resource_group.app_rg[count.index].name
  location            = var.location
  target_resource_id  = module.app_function[count.index].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.app_function_autoscale_default
      minimum = var.app_function_autoscale_minimum
      maximum = var.app_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_function[count.index].id
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
        metric_resource_id       = module.app_function[count.index].app_service_plan_id
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
        metric_resource_id       = module.app_function[count.index].id
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
        metric_resource_id       = module.app_function[count.index].app_service_plan_id
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
