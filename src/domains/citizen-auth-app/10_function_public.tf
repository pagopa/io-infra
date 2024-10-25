#
# APP CONFIGURATION
#

locals {
  function_public = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      # UNIQUE EMAIL ENFORCEMENT
      PROFILE_EMAIL_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.citizen_auth_common.primary_connection_string
      PROFILE_EMAIL_STORAGE_TABLE_NAME        = "profileEmails"

      COSMOSDB_URI      = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY      = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOSDB_NAME     = "db"
      StorageConnection = data.azurerm_storage_account.storage_api.primary_connection_string

      VALIDATION_CALLBACK_URL = "https://api-app.io.pagopa.it/email_verification.html"
      CONFIRM_CHOICE_PAGE_URL = "https://api-app.io.pagopa.it/email_confirm.html"
    }
  }
}

module "function_public_itn" {
  source     = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v8.44.0"
  depends_on = [azurerm_app_service_plan.shared_plan_itn, module.shared_snet_itn]

  resource_group_name = azurerm_resource_group.shared_rg_itn.name
  name                = format("%s-public-func-01", local.short_project_itn)
  location            = local.itn_location
  domain              = "auth"
  health_check_path   = "/info"

  node_version    = "20"
  runtime_version = "~4"

  app_service_plan_id = azurerm_app_service_plan.shared_plan_itn.id

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_public.app_settings_common,
  )

  internal_storage = {
    "enable"                     = false,
    "private_endpoint_subnet_id" = data.azurerm_subnet.itn_pep.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 0,
  }

  subnet_id = module.shared_snet_itn.id

  allowed_subnets = [
  ]

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}

module "function_public_staging_slot_itn" {
  source     = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v8.44.0"
  depends_on = [azurerm_app_service_plan.shared_plan_itn, module.shared_snet_itn]

  name                = "staging"
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.shared_rg_itn.name
  function_app_id     = module.function_public_itn.id
  app_service_plan_id = module.function_public_itn.app_service_plan_id
  health_check_path   = "/info"

  storage_account_name       = module.function_public_itn.storage_account.name
  storage_account_access_key = module.function_public_itn.storage_account.primary_access_key

  node_version                             = "20"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_public.app_settings_common,
  )

  subnet_id = module.shared_snet_itn.id

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_public_itn" {
  name                = format("%s-autoscale", module.function_public_itn.name)
  resource_group_name = azurerm_resource_group.shared_rg_itn.name
  location            = local.itn_location
  target_resource_id  = module.function_public_itn.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_public_autoscale_default
      minimum = var.function_public_autoscale_minimum
      maximum = var.function_public_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_public_itn.id
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
        metric_resource_id       = module.function_public_itn.app_service_plan_id
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
        metric_resource_id       = module.function_public_itn.id
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
        metric_resource_id       = module.function_public_itn.app_service_plan_id
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
