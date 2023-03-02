########################
# SECRETS
########################
data "azurerm_key_vault_secret" "fn_services_mailup_username" {
  name         = "common-MAILUP-USERNAME"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_mailup_secret" {
  name         = "common-MAILUP-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_webhook_channel_url" {
  name         = "appbackend-WEBHOOK-CHANNEL-URL"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_webhook_channel_aks_url" {
  name         = "appbackend-WEBHOOK-CHANNEL-AKS-URL"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_sandbox_fiscal_code" {
  name         = "io-SANDBOX-FISCAL-CODE"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_email_service_blacklist_id" {
  name         = "io-EMAIL-SERVICE-BLACKLIST-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_notification_service_blacklist_id" {
  name         = "io-NOTIFICATION-SERVICE-BLACKLIST-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_beta_users" {
  name         = "io-fn-services-BETA-USERS"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_io_service_key" {
  name         = "apim-IO-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

#
# APP CONFIGURATION
#

locals {
  function_services = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_VNET_ROUTE_ALL         = "1"
      WEBSITE_DNS_SERVER             = "168.63.129.16"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

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

      COSMOSDB_NAME = "db"
      COSMOSDB_URI  = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY  = data.azurerm_cosmosdb_account.cosmos_api.primary_key

      MESSAGE_CONTENT_STORAGE_CONNECTION_STRING   = data.azurerm_storage_account.api.primary_connection_string
      SUBSCRIPTION_FEED_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.api.primary_connection_string

      MAIL_FROM = "IO - l'app dei servizi pubblici <no-reply@io.italia.it>"
      // we keep this while we wait for new app version to be deployed
      MAIL_FROM_DEFAULT = "IO - l'app dei servizi pubblici <no-reply@io.italia.it>"

      IO_FUNCTIONS_ADMIN_BASE_URL       = "https://api-app.internal.io.pagopa.it"
      APIM_BASE_URL                     = "https://api-app.internal.io.pagopa.it"
      DEFAULT_SUBSCRIPTION_PRODUCT_NAME = "io-services-api"

      // setting to true all the webhook message content will be disabled
      FF_DISABLE_WEBHOOK_MESSAGE_CONTENT = "false"

      OPT_OUT_EMAIL_SWITCH_DATE = local.opt_out_email_switch_date
      FF_OPT_IN_EMAIL_ENABLED   = local.ff_opt_in_email_enabled

      # setting to allow the retrieve of the payment status from payment-updater
      FF_PAYMENT_STATUS_ENABLED = "true"

      // minimum app version that introduces read status opt-out
      // NOTE: right now is set to a non existing version, since it's not yet deployed
      // This way we can safely deploy fn-services without enabling ADVANCED functionalities
      MIN_APP_VERSION_WITH_READ_AUTH = "2.14.0"

      // the duration of message and message-status for those messages sent to user not registered on IO.
      TTL_FOR_USER_NOT_FOUND = "${60 * 60 * 24 * 365 * 3}" //3 years in seconds
      FEATURE_FLAG           = "ALL"

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
      BETA_USERS                             = data.azurerm_key_vault_secret.fn_services_beta_users.value
    }
    app_settings_1 = {
      WEBHOOK_CHANNEL_URL = data.azurerm_key_vault_secret.fn_services_webhook_channel_url.value
    }
    app_settings_2 = {
      WEBHOOK_CHANNEL_URL = data.azurerm_key_vault_secret.fn_services_webhook_channel_aks_url.value
    }
  }
}

# Subnet to host app function
module "services_snet" {
  count                                     = var.function_services_count
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.15"
  name                                      = format("%s-services-snet-%d", local.project, count.index + 1)
  address_prefixes                          = [var.cidr_subnet_services[count.index]]
  resource_group_name                       = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                      = data.azurerm_virtual_network.vnet_common.name
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

resource "azurerm_resource_group" "services_rg" {
  count    = var.function_services_count
  name     = format("%s-services-rg-%d", local.project, count.index + 1)
  location = var.location

  tags = var.tags
}

#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "function_services" {
  count  = var.function_services_count
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v4.1.15"

  domain = "IO-COMMONS"

  resource_group_name = azurerm_resource_group.services_rg[count.index].name
  name                = format("%s-services-fn-%d", local.project, count.index + 1)
  location            = var.location
  health_check_path   = "/api/info"

  os_type          = "linux"
  linux_fx_version = "NODE|14"
  runtime_version  = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_services_kind
    sku_tier                     = var.function_services_sku_tier
    sku_size                     = var.function_services_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = merge(
    local.function_services.app_settings_common,
    count.index == 0 ? local.function_services.app_settings_1 : {},
    count.index == 1 ? local.function_services.app_settings_2 : {},
    {
      # Disabled functions on slot - trigger, queue and timer
      # mark this configurations as slot settings
      "AzureWebJobs.CreateNotification.Disabled"     = "0"
      "AzureWebJobs.EmailNotification.Disabled"      = "0"
      "AzureWebJobs.OnFailedProcessMessage.Disabled" = "0"
      "AzureWebJobs.ProcessMessage.Disabled"         = "0"
      "AzureWebJobs.WebhookNotification.Disabled"    = "0"
    }
  )

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = module.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues" = [
      "message-created",
      "message-created-poison",
      "message-processed",
      "message-processed-poison",
      "notification-created-email",
      "notification-created-email-poison",
      "notification-created-webhook",
      "notification-created-webhook-poison",
    ],
    "containers" = [
      "processing-messages",
    ],
    "blobs_retention_days" = 1,
  }

  subnet_id = module.services_snet[count.index].id

  allowed_subnets = [
    module.services_snet[count.index].id,
    data.azurerm_subnet.azdoa_snet[0].id,
    module.apim_snet.id,
    module.function_eucovidcert_snet.id,
  ]


  # Action groups for alerts
  action = [
    {
      action_group_id    = azurerm_monitor_action_group.error_action_group.id
      webhook_properties = null
    }
  ]


  tags = var.tags
}

module "function_services_staging_slot" {
  count  = var.function_services_count
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v4.1.15"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.services_rg[count.index].name
  function_app_name   = module.function_services[count.index].name
  function_app_id     = module.function_services[count.index].id
  app_service_plan_id = module.function_services[count.index].app_service_plan_id
  health_check_path   = "/api/info"

  storage_account_name               = module.function_services[count.index].storage_account.name
  storage_account_access_key         = module.function_services[count.index].storage_account.primary_access_key
  internal_storage_connection_string = module.function_services[count.index].storage_account_internal_function.primary_connection_string

  os_type                                  = "linux"
  linux_fx_version                         = "NODE|14"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_services.app_settings_common, {
      # Disabled functions on slot - trigger, queue and timer
      # mark this configurations as slot settings
      "AzureWebJobs.CreateNotification.Disabled"     = "1"
      "AzureWebJobs.EmailNotification.Disabled"      = "1"
      "AzureWebJobs.OnFailedProcessMessage.Disabled" = "1"
      "AzureWebJobs.ProcessMessage.Disabled"         = "1"
      "AzureWebJobs.WebhookNotification.Disabled"    = "1"
    }
  )

  subnet_id = module.services_snet[count.index].id

  allowed_subnets = [
    module.services_snet[count.index].id,
    data.azurerm_subnet.azdoa_snet[0].id,
    module.apim_snet.id,
    module.function_eucovidcert_snet.id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_services_autoscale" {
  count               = var.function_services_count
  name                = format("%s-autoscale", module.function_services[count.index].name)
  resource_group_name = azurerm_resource_group.services_rg[count.index].name
  location            = var.location
  target_resource_id  = module.function_services[count.index].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_services_autoscale_default
      minimum = var.function_services_autoscale_minimum
      maximum = var.function_services_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_services[count.index].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 2500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "3"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_services[count.index].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 40
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "3"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_services[count.index].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 1500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_services[count.index].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 25
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }
  }
}

# Cosmos container for subscription cidrs
module "db_subscription_cidrs_container" {
  source   = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v2.15.1"
  name                = "subscription-cidrs"
  resource_group_name = format("%s-rg-internal", local.project)
  account_name        = format("%s-cosmos-api", local.project)
  database_name       = locals.function_services.app_settings_common.COSMOSDB_NAME
  partition_key_path  = "/subscriptionId"
}
