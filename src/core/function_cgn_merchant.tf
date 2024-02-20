#
# APP CONFIGURATION
#

locals {
  function_cgn_merchant = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_DNS_SERVER             = "168.63.129.16"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      COSMOSDB_CGN_URI           = data.azurerm_cosmosdb_account.cosmos_cgn.endpoint
      COSMOSDB_CGN_KEY           = data.azurerm_cosmosdb_account.cosmos_cgn.primary_key
      COSMOSDB_CGN_DATABASE_NAME = "db"
      COSMOSDB_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_cgn.endpoint, data.azurerm_cosmosdb_account.cosmos_cgn.primary_key)

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      # Storage account connection string:
      CGN_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.iopstcgn.primary_connection_string

      // REDIS
      REDIS_URL      = data.azurerm_redis_cache.redis_cgn.hostname
      REDIS_PORT     = data.azurerm_redis_cache.redis_cgn.ssl_port
      REDIS_PASSWORD = data.azurerm_redis_cache.redis_cgn.primary_access_key
    }
  }
}

#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "function_cgn_merchant" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v7.61.0"

  resource_group_name = azurerm_resource_group.cgn_be_rg.name
  name                = format("%s-cgn-merchant-fn", local.project)
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.cgn_common.id
  health_check_path   = "/api/v1/merchant/cgn/info"

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_cgn_merchant.app_settings_common,
  )

  subnet_id = module.cgn_snet.id

  allowed_subnets = [
    module.cgn_snet.id,
    module.apim_v2_snet.id,
  ]

  tags = var.tags
}

module "function_cgn_merchant_staging_slot" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v7.61.0"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.cgn_be_rg.name
  function_app_id     = module.function_cgn_merchant.id
  app_service_plan_id = azurerm_app_service_plan.cgn_common.id
  health_check_path   = "/api/v1/merchant/cgn/info"

  storage_account_name       = module.function_cgn_merchant.storage_account.name
  storage_account_access_key = module.function_cgn_merchant.storage_account.primary_access_key

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_cgn_merchant.app_settings_common,
  )

  subnet_id = module.cgn_snet.id

  allowed_subnets = [
    module.cgn_snet.id,
    module.azdoa_snet[0].id,
    module.apim_v2_snet.id,
  ]

  tags = var.tags
}

## Alerts

resource "azurerm_monitor_metric_alert" "function_cgn_merchant_health_check" {
  name                = "${module.function_cgn_merchant.name}-health-check-failed"
  resource_group_name = azurerm_resource_group.cgn_be_rg.name
  scopes              = [module.function_cgn_merchant.id]
  description         = "${module.function_cgn_merchant.name} health check failed"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false
  enabled             = false # todo enable after deploy

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
