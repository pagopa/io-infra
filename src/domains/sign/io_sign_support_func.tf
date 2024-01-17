locals {
  io_sign_support_func = {
    app_settings = {
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      AzureWebJobsDisableHomepage    = "true"
      NODE_ENV                       = "production"
      CosmosDbConnectionString       = module.cosmosdb_account.connection_strings[0]
      CosmosDbIssuerDatabaseName     = module.cosmosdb_sql_database_issuer.name
      CosmosDbUserDatabaseName       = module.cosmosdb_sql_database_user.name
      PdvTokenizerApiBasePath        = "https://api.tokenizer.pdv.pagopa.it"
      PdvTokenizerApiKey             = module.key_vault_secrets.values["PdvTokenizerApiKey"].value
    }
  }
}

module "io_sign_support_func" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v7.46.0"

  name                = format("%s-support-func", local.project)
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  # TODO Activate when in production
  # health_check_path = "/api/v1/sign/support/info"

  always_on = true

  runtime_version = "~4"
  node_version    = "18"

  app_service_plan_info = {
    kind                         = "Linux"
    sku_tier                     = var.io_sign_support_func.sku_tier
    sku_size                     = var.io_sign_support_func.sku_size
    maximum_elastic_worker_count = 0
    worker_count                 = 1
    zone_balancing_enabled       = false
  }

  app_settings = local.io_sign_support_func.app_settings

  subnet_id = module.io_sign_support_snet.id
  allowed_subnets = [
    module.io_sign_support_snet.id,
    data.azurerm_subnet.apim_v2.id,
  ]

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  system_identity_enabled                  = true

  tags = var.tags
}

module "io_sign_support_func_staging_slot" {
  count  = var.io_sign_support_func.sku_tier == "PremiumV3" ? 1 : 0
  source = "github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v7.46.0"

  name                = "staging"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
  function_app_id     = module.io_sign_support_func.id
  app_service_plan_id = module.io_sign_support_func.app_service_plan_id

  # TODO Activate when in production
  # health_check_path = "/api/v1/sign/support/info"

  storage_account_name       = module.io_sign_support_func.storage_account.name
  storage_account_access_key = module.io_sign_support_func.storage_account.primary_access_key

  runtime_version                          = "~4"
  always_on                                = true
  node_version                             = "18"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = local.io_sign_support_func.app_settings

  subnet_id = module.io_sign_support_snet.id
  allowed_subnets = [
    module.io_sign_support_snet.id,
    data.azurerm_subnet.apim_v2.id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "io_sign_support_func" {
  count               = var.io_sign_support_func.sku_tier == "PremiumV3" ? 1 : 0
  name                = format("%s-autoscale", module.io_sign_support_func.name)
  resource_group_name = azurerm_resource_group.backend_rg.name
  location            = azurerm_resource_group.backend_rg.location
  target_resource_id  = module.io_sign_support_func.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.io_sign_support_func.autoscale_default
      minimum = var.io_sign_support_func.autoscale_minimum
      maximum = var.io_sign_support_func.autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.io_sign_support_func.id
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
        metric_resource_id       = module.io_sign_support_func.app_service_plan_id
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
        metric_resource_id       = module.io_sign_support_func.id
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
        metric_resource_id       = module.io_sign_support_func.app_service_plan_id
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
