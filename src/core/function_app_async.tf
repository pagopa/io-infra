#
# APP CONFIGURATION
#

locals {
  function_app_async = {
    app_settings_common = local.function_app.app_settings_common
    app_settings_1 = {
    }
    app_settings_2 = {
    }
  }
}

resource "azurerm_resource_group" "app_async_rg" {
  name     = format("%s-app-async-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host app function
module "app_async_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.61.0"
  name                                      = format("%s-app-async-snet", local.project)
  address_prefixes                          = var.cidr_subnet_app_async
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
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

#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "function_app_async" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v7.61.0"

  resource_group_name = azurerm_resource_group.app_async_rg.name
  name                = format("%s-app-async-fn", local.project)
  location            = var.location
  health_check_path   = "/api/v1/info"

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_app_async_kind
    sku_tier                     = var.function_app_async_sku_tier
    sku_size                     = var.function_app_async_sku_size
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = null
  }

  app_settings = merge(
    local.function_app_async.app_settings_common, {
      "AzureWebJobs.StoreSpidLogs.Disabled"   = "0",
      "AzureWebJobs.OnProfileUpdate.Disabled" = "0",
    }
  )

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = module.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [azurerm_private_dns_zone.privatelink_blob_core.id],
    "private_dns_zone_queue_ids" = [azurerm_private_dns_zone.privatelink_queue_core.id],
    "private_dns_zone_table_ids" = [azurerm_private_dns_zone.privatelink_table_core.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 1,
  }

  subnet_id = module.app_async_snet.id

  allowed_subnets = [
    module.app_async_snet.id,
  ]

  sticky_app_setting_names = concat([
    "AzureWebJobs.HandleNHNotificationCall.Disabled",
    "AzureWebJobs.StoreSpidLogs.Disabled",
    "AzureWebJobs.OnProfileUpdate.Disabled"
    ]
  )

  tags = var.tags
}

module "function_app_async_staging_slot" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v7.61.0"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.app_async_rg.name
  function_app_id     = module.function_app_async.id
  app_service_plan_id = module.function_app_async.app_service_plan_id
  health_check_path   = "/api/v1/info"

  storage_account_name               = module.function_app_async.storage_account.name
  storage_account_access_key         = module.function_app_async.storage_account.primary_access_key
  internal_storage_connection_string = module.function_app_async.storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_app_async.app_settings_common, {
      "AzureWebJobs.StoreSpidLogs.Disabled"   = "1",
      "AzureWebJobs.OnProfileUpdate.Disabled" = "1",
    }
  )

  subnet_id = module.app_async_snet.id

  allowed_subnets = [
    module.app_async_snet.id,
    module.azdoa_snet[0].id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_app_async" {
  name                = format("%s-autoscale", module.function_app_async.name)
  resource_group_name = azurerm_resource_group.app_async_rg.name
  location            = var.location
  target_resource_id  = module.function_app_async.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_app_async_autoscale_default
      minimum = var.function_app_async_autoscale_minimum
      maximum = var.function_app_async_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_app_async.id
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
        metric_resource_id       = module.function_app_async.app_service_plan_id
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
        metric_resource_id       = module.function_app_async.id
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
        metric_resource_id       = module.function_app_async.app_service_plan_id
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

resource "azurerm_monitor_metric_alert" "function_app_async_health_check" {
  name                = "${module.function_app_async.name}-health-check-failed"
  resource_group_name = azurerm_resource_group.app_async_rg.name
  scopes              = [module.function_app_async.id]
  description         = "${module.function_app_async.name} health check failed"
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
    action_group_id = azurerm_monitor_action_group.error_action_group.id
  }
}



# Container

# Cosmos container for subscription cidrs
module "db_subscription_profileemails_container" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.61.0"
  name                = "profile-emails-leases"
  resource_group_name = format("%s-rg-internal", local.project)
  account_name        = format("%s-cosmos-api", local.project)
  database_name       = local.function_app_async.app_settings_common.COSMOSDB_NAME
  partition_key_path  = "/_partitionKey"

  autoscale_settings = {
    max_throughput = 1000
  }
}
