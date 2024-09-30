#
# APP CONFIGURATION
#

locals {
  function_profile_async = {
    app_settings_common = merge(local.function_profile.app_settings_common, local.function_profile.app_settings_async)
  }
}

resource "azurerm_resource_group" "function_profile_async_rg" {
  name     = format("%s-profile-async-rg-01", local.project_itn)
  location = local.itn_location

  tags = var.tags
}

module "function_profile_async" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v8.44.0"

  resource_group_name = azurerm_resource_group.function_profile_async_rg.name
  name                = format("%s-as-prof-fn-01", local.short_project_itn)
  location            = local.itn_location
  health_check_path   = "/api/v1/info"

  enable_function_app_public_network_access = false

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_profile_async_kind
    sku_tier                     = var.function_profile_async_sku_tier
    sku_size                     = var.function_profile_async_sku_size
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = true
  }

  app_settings = merge(
    local.function_profile_async.app_settings_common, {
      "AzureWebJobs.StoreSpidLogs.Disabled"   = "0",
      "AzureWebJobs.OnProfileUpdate.Disabled" = "0",
    }
  )

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.itn_pep.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 1,
  }

  subnet_id = module.fn_profile_async_snet.id

  sticky_app_setting_names = concat([
    "AzureWebJobs.HandleNHNotificationCall.Disabled",
    "AzureWebJobs.StoreSpidLogs.Disabled",
    "AzureWebJobs.OnProfileUpdate.Disabled"
    ]
  )

  tags = var.tags
}

module "function_profile_async_staging_slot" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v8.44.0"

  name                = "staging"
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.function_profile_async_rg.name
  function_app_id     = module.function_profile_async.id
  app_service_plan_id = module.function_profile_async.app_service_plan_id
  health_check_path   = "/api/v1/info"

  enable_function_app_public_network_access = false

  storage_account_name               = module.function_profile_async.storage_account.name
  storage_account_access_key         = module.function_profile_async.storage_account.primary_access_key
  internal_storage_connection_string = module.function_profile_async.storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_profile_async.app_settings_common, {
      "AzureWebJobs.StoreSpidLogs.Disabled"   = "1",
      "AzureWebJobs.OnProfileUpdate.Disabled" = "1",
    }
  )

  subnet_id = module.fn_profile_async_snet.id

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_profile_async" {
  name                = format("%s-autoscale", module.function_profile_async.name)
  resource_group_name = azurerm_resource_group.function_profile_async_rg.name
  location            = local.itn_location
  target_resource_id  = module.function_profile_async.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_profile_async_autoscale_default
      minimum = var.function_profile_async_autoscale_minimum
      maximum = var.function_profile_async_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_profile_async.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT1M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_profile_async.app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT1M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 45
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_profile_async.id
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
        metric_resource_id       = module.function_profile_async.app_service_plan_id
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

## Alerts

resource "azurerm_monitor_metric_alert" "function_profile_async_health_check" {
  name                = "${module.function_profile_async.name}-health-check-failed"
  resource_group_name = azurerm_resource_group.function_profile_async_rg.name
  scopes              = [module.function_profile_async.id]
  description         = "${module.function_profile_async.name} health check failed"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 50
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.error_action_group.id
  }
}
