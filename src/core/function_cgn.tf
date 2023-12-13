#
# SECRETS
#

data "azurerm_key_vault_secret" "fn_cgn_SERVICES_API_KEY" {
  name         = "apim-CGN-SERVICE-KEY"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_cgn_EYCA_API_USERNAME" {
  name         = "funccgn-EYCA-API-USERNAME"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_cgn_EYCA_API_PASSWORD" {
  name         = "funccgn-EYCA-API-PASSWORD"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_cgn_CGN_SERVICE_ID" {
  name         = "funccgn-CGN-SERVICE-ID"
  key_vault_id = module.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_cgn_CGN_DATA_BACKUP_CONNECTION" {
  name         = "cgn-legalbackup-storage-connection-string"
  key_vault_id = module.key_vault_common.id
}

#
# APP CONFIGURATION
#

locals {
  function_cgn = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_VNET_ROUTE_ALL         = "1"
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

      CGN_EXPIRATION_TABLE_NAME  = "cardexpiration"
      EYCA_EXPIRATION_TABLE_NAME = "eycacardexpiration"

      # Storage account connection string:
      CGN_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.iopstcgn.primary_connection_string

      SERVICES_API_URL = "http://api-app.internal.io.pagopa.it/"

      WEBSITE_TIME_ZONE = local.cet_time_zone_win
      EYCA_API_BASE_URL = "https://ccdb.eyca.org/api"

      // REDIS
      REDIS_URL      = data.azurerm_redis_cache.redis_cgn.hostname
      REDIS_PORT     = data.azurerm_redis_cache.redis_cgn.ssl_port
      REDIS_PASSWORD = data.azurerm_redis_cache.redis_cgn.primary_access_key

      OTP_TTL_IN_SECONDS = 600

      CGN_UPPER_BOUND_AGE  = 36
      EYCA_UPPER_BOUND_AGE = 31

      CGN_CARDS_DATA_BACKUP_CONTAINER_NAME = "cgn-legalbackup-blob"
      CGN_CARDS_DATA_BACKUP_FOLDER_NAME    = "cgn"

      #
      # SECRETS VALUES
      #
      SERVICES_API_KEY           = data.azurerm_key_vault_secret.fn_cgn_SERVICES_API_KEY.value
      EYCA_API_USERNAME          = data.azurerm_key_vault_secret.fn_cgn_EYCA_API_USERNAME.value
      EYCA_API_PASSWORD          = data.azurerm_key_vault_secret.fn_cgn_EYCA_API_PASSWORD.value
      CGN_SERVICE_ID             = data.azurerm_key_vault_secret.fn_cgn_CGN_SERVICE_ID.value
      CGN_DATA_BACKUP_CONNECTION = data.azurerm_key_vault_secret.fn_cgn_CGN_DATA_BACKUP_CONNECTION.value
    }
  }
}

#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "function_cgn" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v7.28.0"

  resource_group_name = azurerm_resource_group.cgn_be_rg.name
  name                = format("%s-cgn-fn", local.project)
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.cgn_common.id
  health_check_path   = "/api/v1/cgn/info"

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_cgn.app_settings_common, {
      "AzureWebJobs.ContinueEycaActivation.Disabled" = "0",
      "AzureWebJobs.UpdateExpiredCgn.Disabled"       = "0",
      "AzureWebJobs.UpdateExpiredEyca.Disabled"      = "0"
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
    "blobs_retention_days"       = 0,
  }

  subnet_id = module.cgn_snet.id

  allowed_subnets = [
    module.cgn_snet.id,
    module.app_backendl1_snet.id,
    module.app_backendl2_snet.id,
    module.app_backendli_snet.id,
    module.apim_v2_snet.id,
  ]

  sticky_app_setting_names = [
    "AzureWebJobs.ContinueEycaActivation.Disabled",
    "AzureWebJobs.UpdateExpiredCgn.Disabled",
    "AzureWebJobs.UpdateExpiredEyca.Disabled"
  ]

  tags = var.tags
}

module "function_cgn_staging_slot" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v7.28.0"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.cgn_be_rg.name
  function_app_id     = module.function_cgn.id
  app_service_plan_id = azurerm_app_service_plan.cgn_common.id
  health_check_path   = "/api/v1/cgn/info"

  storage_account_name       = module.function_cgn.storage_account.name
  storage_account_access_key = module.function_cgn.storage_account.primary_access_key

  internal_storage_connection_string = module.function_cgn.storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_cgn.app_settings_common, {
      "AzureWebJobs.ContinueEycaActivation.Disabled" = "1",
      "AzureWebJobs.UpdateExpiredCgn.Disabled"       = "1",
      "AzureWebJobs.UpdateExpiredEyca.Disabled"      = "1"
    }
  )

  subnet_id = module.cgn_snet.id

  allowed_subnets = [
    module.cgn_snet.id,
    module.azdoa_snet[0].id,
    module.app_backendl1_snet.id,
    module.app_backendl2_snet.id,
    module.app_backendli_snet.id,
    module.apim_v2_snet.id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_cgn" {
  name                = format("%s-autoscale", module.function_cgn.name)
  resource_group_name = azurerm_resource_group.cgn_be_rg.name
  location            = var.location
  target_resource_id  = module.function_cgn.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_cgn_autoscale_default
      minimum = var.function_cgn_autoscale_minimum
      maximum = var.function_cgn_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_cgn.id
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
        metric_resource_id       = module.function_cgn.app_service_plan_id
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
        metric_resource_id       = module.function_cgn.id
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
        metric_resource_id       = module.function_cgn.app_service_plan_id
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

resource "azurerm_monitor_metric_alert" "function_cgn_health_check" {
  name                = "${module.function_cgn.name}-health-check-failed"
  resource_group_name = azurerm_resource_group.cgn_be_rg.name
  scopes              = [module.function_cgn.id]
  description         = "${module.function_cgn.name} health check failed"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false
  enabled             = true

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
