resource "azurerm_resource_group" "push_notif_rg" {
  name     = format("%s-push-notif-rg", local.project)
  location = var.location

  tags = var.tags
}



locals {
  function_push_notif = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      FISCAL_CODE_NOTIFICATION_BLACKLIST = join(",", local.test_users_internal_load)

      NOTIFICATIONS_QUEUE_NAME                = "push-notifications"
      NOTIFICATIONS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.push_notifications_storage.primary_connection_string

      NOTIFY_MESSAGE_QUEUE_NAME = "notify-message"

      // activity default retry attempts
      RETRY_ATTEMPT_NUMBER = 10


      # ------------------------------------------------------------------------------
      # Notification Hubs variables

      # Endpoint for the test notification hub namespace
      AZURE_NH_HUB_NAME                                = data.azurerm_notification_hub.common.name
      "AzureWebJobs.HandleNHNotificationCall.Disabled" = "0"
      # Endpoint for the test notification hub namespace
      NH1_PARTITION_REGEX = "^[0-3]"
      NH1_NAME            = data.azurerm_notification_hub.common_partition[0].name
      NH2_PARTITION_REGEX = "^[4-7]"
      NH2_NAME            = data.azurerm_notification_hub.common_partition[1].name
      NH3_PARTITION_REGEX = "^[8-b]"
      NH3_NAME            = data.azurerm_notification_hub.common_partition[2].name
      NH4_PARTITION_REGEX = "^[c-f]"
      NH4_NAME            = data.azurerm_notification_hub.common_partition[3].name

      AZURE_NH_ENDPOINT = data.azurerm_key_vault_secret.azure_nh_endpoint.value
      NH1_ENDPOINT      = data.azurerm_key_vault_secret.azure_nh_partition1_endpoint.value
      NH2_ENDPOINT      = data.azurerm_key_vault_secret.azure_nh_partition2_endpoint.value
      NH3_ENDPOINT      = data.azurerm_key_vault_secret.azure_nh_partition3_endpoint.value
      NH4_ENDPOINT      = data.azurerm_key_vault_secret.azure_nh_partition4_endpoint.value
      # ------------------------------------------------------------------------------


      # ------------------------------------------------------------------------------
      # Variable used during transition to new NH management

      # Possible values : "none" | "all" | "beta" | "canary"
      NH_PARTITION_FEATURE_FLAG            = "all"
      NOTIFY_VIA_QUEUE_FEATURE_FLAG        = "all"
      BETA_USERS_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.push_notif_beta_storage.primary_connection_string
      BETA_USERS_TABLE_NAME                = "notificationhub"

      # Takes ~6,25% of users
      CANARY_USERS_REGEX = "^([(0-9)|(a-f)|(A-F)]{63}0)$"
      # ------------------------------------------------------------------------------

      AzureFunctionsJobHost__extensions__durableTask__storageProvider__partitionCount = "8"

    }
    app_settings_1 = {
    }
    app_settings_2 = {
    }
  }
}



# Subnet to host push notif function
module "push_notif_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-push-notif-snet", local.project)
  address_prefixes                               = var.cidr_subnet_push_notif
  resource_group_name                            = data.azurerm_virtual_network.vnet_common.resource_group_name
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
module "push_notif_function" {
  count  = var.push_notif_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v3.8.1"

  resource_group_name = azurerm_resource_group.push_notif_rg.name
  name                = format("%s-push-notif-fn", local.product)
  domain              = upper(var.domain)
  location            = var.location
  health_check_path   = "/api/v1/info"

  os_type                                  = "linux"
  runtime_version                          = "~4"
  linux_fx_version                         = "NODE|14"
  always_on                                = var.push_notif_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.push_notif_function_kind
    sku_tier                     = var.push_notif_function_sku_tier
    sku_size                     = var.push_notif_function_sku_size
    maximum_elastic_worker_count = 0
  }

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 1,
  }

  app_settings = merge(
    local.function_push_notif.app_settings_common,
    "AzureWebJobs.HandleNHNotificationCall.Disabled" = "0"
  )

  subnet_id = module.push_notif_snet.id

  allowed_subnets = [
    module.push_notif_snet.id
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}

module "push_notif_function_staging_slot" {
  count  = var.push_notif_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v3.8.1"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.push_notif_rg.name
  function_app_name   = module.push_notif_function[0].name
  function_app_id     = module.push_notif_function[0].id
  app_service_plan_id = module.push_notif_function[0].app_service_plan_id
  health_check_path   = "/api/v1/info"

  storage_account_name       = module.push_notif_function[0].storage_account.name
  storage_account_access_key = module.push_notif_function[0].storage_account.primary_access_key

  internal_storage_connection_string = module.push_notif_function[0].storage_account_internal_function.primary_connection_string

  os_type                                  = "linux"
  runtime_version                          = "~4"
  linux_fx_version                         = "NODE|14"
  always_on                                = var.push_notif_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_push_notif.app_settings_common,
    "AzureWebJobs.HandleNHNotificationCall.Disabled" = "1"
  )

  subnet_id = module.push_notif_snet.id

  allowed_subnets = [
    module.push_notif_snet.id,
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  allowed_ips = concat(
    [],
  )

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "push_notif_function" {
  count               = var.push_notif_enabled ? 1 : 0
  name                = format("%s-autoscale", module.push_notif_function[0].name)
  resource_group_name = azurerm_resource_group.push_notif_rg.name
  location            = var.location
  target_resource_id  = module.push_notif_function[0].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.push_notif_function_autoscale_default
      minimum = var.push_notif_function_autoscale_minimum
      maximum = var.push_notif_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.push_notif_function[0].id
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
        metric_resource_id       = module.push_notif_function[0].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 60
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
        metric_resource_id       = module.push_notif_function[0].id
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
        metric_resource_id       = module.push_notif_function[0].app_service_plan_id
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
