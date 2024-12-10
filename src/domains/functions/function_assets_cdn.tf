data "azurerm_resource_group" "backend_messages_rg" {
  name = "${local.project}-backend-messages-rg"
}

locals {
  function_assets_cdn = {
    app_settings = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
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
      COSMOSDB_KEY  = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOSDB_NAME = "db"

      STATIC_WEB_ASSETS_ENDPOINT  = data.azurerm_storage_account.assets_cdn.primary_web_host
      STATIC_BLOB_ASSETS_ENDPOINT = data.azurerm_storage_account.assets_cdn.primary_blob_host

      CachedStorageConnection = data.azurerm_storage_account.storage_api.primary_connection_string
      AssetsStorageConnection = data.azurerm_storage_account.assets_cdn.primary_connection_string

      AzureWebJobsFeatureFlags = "EnableProxies"
    }
  }
}

# Subnet to host fn cdn assets function
module "function_assets_cdn_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.52.0"
  name                                      = format("%s-assets-cdn-fn-snet", local.project)
  address_prefixes                          = var.cidr_subnet_fncdnassets
  resource_group_name                       = local.rg_common_name
  virtual_network_name                      = local.vnet_common_name
  private_endpoint_network_policies_enabled = false

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
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v8.52.0"

  resource_group_name = local.rg_assets_cdn_name
  name                = "${local.project}-assets-cdn-fn"
  location            = var.location
  health_check_path   = "/info"

  runtime_version                          = "~4"
  node_version                             = "18"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_assets_cdn_kind
    sku_tier                     = var.function_assets_cdn_sku_tier
    sku_size                     = var.function_assets_cdn_sku_size
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = null
  }

  app_settings = local.function_assets_cdn.app_settings

  subnet_id = module.function_assets_cdn_snet.id

  tags = var.tags
}

module "function_assets_cdn_staging_slot" {
  count  = var.function_assets_cdn_sku_tier == "PremiumV3" ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v8.52.0"

  name                = "staging"
  location            = var.location
  resource_group_name = local.rg_assets_cdn_name
  function_app_id     = module.function_assets_cdn.id
  app_service_plan_id = module.function_assets_cdn.app_service_plan_id
  health_check_path   = "/info"

  storage_account_name       = module.function_assets_cdn.storage_account.name
  storage_account_access_key = module.function_assets_cdn.storage_account.primary_access_key

  runtime_version                          = "~4"
  node_version                             = "18"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = local.function_assets_cdn.app_settings

  subnet_id = module.function_assets_cdn_snet.id

  tags = var.tags
}

module "function_assets_cdn_autoscale" {
  source              = "github.com/pagopa/dx//infra/modules/azure_app_service_plan_autoscaler?ref=main"
  resource_group_name = local.rg_assets_cdn_name
  target_service = {
    function_app_name = module.function_assets_cdn.name
  }
  scheduler = {
    normal_load = {
      minimum = 2
      default = 2
    },
    maximum = 10
  }
  scale_metrics = {
    requests = {
      statistic_increase        = "Max"
      time_window_increase      = 1
      time_aggregation          = "Maximum"
      upper_threshold           = 2500
      increase_by               = 2
      cooldown_increase         = 1
      statistic_decrease        = "Average"
      time_window_decrease      = 5
      time_aggregation_decrease = "Average"
      lower_threshold           = 200
      decrease_by               = 1
      cooldown_decrease         = 2
    }
    cpu = {
      upper_threshold           = 50
      lower_threshold           = 15
      increase_by               = 3
      decrease_by               = 1
      cooldown_increase         = 1
      cooldown_decrease         = 2
      statistic_increase        = "Max"
      statistic_decrease        = "Average"
      time_aggregation_increase = "Maximum"
      time_aggregation_decrease = "Average"
      time_window_increase      = 1
      time_window_decrease      = 5
    }
    memory = null
  }
  tags = var.tags
}

## Alerts

resource "azurerm_monitor_metric_alert" "function_assets_health_check" {
  name                = "${module.function_assets_cdn.name}-health-check-failed"
  resource_group_name = local.rg_assets_cdn_name
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
    action_group_id = data.azurerm_monitor_action_group.error_action_group.id
  }
}

resource "azurerm_monitor_metric_alert" "function_assets_http_server_errors" {
  name                = "${module.function_assets_cdn.name}-http-server-errors"
  resource_group_name = local.rg_assets_cdn_name
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
    action_group_id = data.azurerm_monitor_action_group.error_action_group.id
  }
}

resource "azurerm_monitor_metric_alert" "function_assets_response_time" {
  name                = "${module.function_assets_cdn.name}-response-time"
  resource_group_name = local.rg_assets_cdn_name
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
    action_group_id = data.azurerm_monitor_action_group.error_action_group.id
  }
}
