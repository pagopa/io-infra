locals {
  function_assets_cdn = {
    app_settings = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
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

      COSMOSDB_URI  = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY  = data.azurerm_cosmosdb_account.cosmos_api.primary_master_key
      COSMOSDB_NAME = "db"

      STATIC_WEB_ASSETS_ENDPOINT  = data.azurerm_storage_account.cdnassets.primary_web_host
      STATIC_BLOB_ASSETS_ENDPOINT = data.azurerm_storage_account.cdnassets.primary_blob_host

      CachedStorageConnection = data.azurerm_storage_account.api.primary_connection_string
      AssetsStorageConnection = data.azurerm_storage_account.cdnassets.primary_connection_string

      AzureWebJobsFeatureFlags = "EnableProxies"
    }
  }
}

# Subnet to host fn cdn assets function
module "function_assets_cdn_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-assets-cdn-fn-snet", local.project)
  address_prefixes                               = var.cidr_subnet_fncdnassets
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.Storage",
    "Microsoft.AzureCosmosDB",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "function_assets_cdn" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v3.4.0"

  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  name                = "${local.project}-assets-cdn-fn"
  location            = var.location
  health_check_path   = "info"

  os_type                                  = "linux"
  runtime_version                          = "~4"
  linux_fx_version                         = "NODE|14"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_assets_cdn_kind
    sku_tier                     = var.function_assets_cdn_sku_tier
    sku_size                     = var.function_assets_cdn_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = local.function_assets_cdn.app_settings

  subnet_id = module.function_assets_cdn_snet.id

  tags = var.tags
}

module "function_assets_cdn_staging_slot" {
  count  = var.function_assets_cdn_sku_tier == "PremiumV3" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v3.4.0"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  function_app_name   = module.function_assets_cdn.name
  function_app_id     = module.function_assets_cdn.id
  app_service_plan_id = module.function_assets_cdn.app_service_plan_id
  health_check_path   = "info"

  storage_account_name       = module.function_assets_cdn.storage_account.name
  storage_account_access_key = module.function_assets_cdn.storage_account.primary_access_key

  os_type                                  = "linux"
  runtime_version                          = "~4"
  linux_fx_version                         = "NODE|14"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = local.function_assets_cdn.app_settings

  subnet_id = module.function_assets_cdn_snet.id

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_assets_cdn" {
  count               = var.function_assets_cdn_sku_tier == "PremiumV3" ? 1 : 0
  name                = format("%s-autoscale", module.function_assets_cdn.name)
  resource_group_name = azurerm_resource_group.backend_messages_rg.name
  location            = var.location
  target_resource_id  = module.function_assets_cdn.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_assets_cdn_autoscale_default
      minimum = var.function_assets_cdn_autoscale_minimum
      maximum = var.function_assets_cdn_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_assets_cdn.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3500
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
        metric_resource_id       = module.function_assets_cdn.app_service_plan_id
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
        metric_resource_id       = module.function_assets_cdn.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2500
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
        metric_resource_id       = module.function_assets_cdn.app_service_plan_id
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

resource "azurerm_monitor_metric_alert" "function_assets_health_check" {
  name                = "${module.function_assets_cdn.name}-health-check-failed"
  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  scopes              = [module.function_assets_cdn.id]
  description         = "${module.function_assets_cdn.name} health check failed"
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
    action_group_id = azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack.id
  }
}

resource "azurerm_monitor_metric_alert" "function_assets_http_server_errors" {
  name                = "${module.function_assets_cdn.name}-http-server-errors"
  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  scopes              = [module.function_assets_cdn.id]
  description         = "${module.function_assets_cdn.name} http server errors"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 50
  }

  action {
    action_group_id = azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack.id
  }
}

resource "azurerm_monitor_metric_alert" "function_assets_response_time" {
  name                = "${module.function_assets_cdn.name}-response-time"
  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  scopes              = [module.function_assets_cdn.id]
  description         = "${module.function_assets_cdn.name} response time is greater than 0.5s"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HttpResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0.5
  }

  action {
    action_group_id = azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack.id
  }
}
