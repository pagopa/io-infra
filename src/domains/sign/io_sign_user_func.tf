locals {
  io_sign_user_func = {
    staging_disabled = [
      "CreateSignatureRequest",
      "FillDocument",
      "UpdateSignatureRequest",
      "ValidateQtspSignature",
    ]
    app_settings = {
      FUNCTIONS_WORKER_PROCESS_COUNT    = 4
      AzureWebJobsDisableHomepage       = "true"
      NODE_ENV                          = "production"
      NODE_TLS_REJECT_UNAUTHORIZED      = 0
      CosmosDbConnectionString          = module.cosmosdb_account.connection_strings[0]
      CosmosDbDatabaseName              = module.cosmosdb_sql_database_user.name
      StorageAccountConnectionString    = module.io_sign_storage.primary_connection_string
      userUploadedBlobContainerName     = azurerm_storage_container.uploaded_documents.name
      userValidatedBlobContainerName    = azurerm_storage_container.validated_documents.name
      IoServicesApiBasePath             = "https://api.io.pagopa.it"
      IoServicesSubscriptionKey         = module.key_vault_secrets.values["IoServicesSubscriptionKey"].value
      IoServicesConfigurationId         = module.key_vault_secrets.values["io-services-configuration-id"].value
      PdvTokenizerApiBasePath           = "https://api.tokenizer.pdv.pagopa.it"
      PdvTokenizerApiKey                = module.key_vault_secrets.values["PdvTokenizerApiKey"].value
      NamirialApiBasePath               = "https://pagopa.namirial.com"
      NamirialUsername                  = "api"
      NamirialPassword                  = module.key_vault_secrets.values["NamirialPassword"].value
      NamirialTestApiBasePath           = "https://pagopa-test.namirial.com"
      NamirialTestUsername              = "api"
      NamirialTestPassword              = module.key_vault_secrets.values["NamirialTestPassword"].value
      AnalyticsEventHubConnectionString = module.event_hub.keys["analytics.io-sign-func-user"].primary_connection_string
      BillingEventHubConnectionString   = module.event_hub.keys["billing.io-sign-func-issuer"].primary_connection_string
      SelfCareEventHubConnectionString  = module.key_vault_secrets.values["SelfCareEventHubConnectionString"].value
      SelfCareApiBasePath               = "https://api.selfcare.pagopa.it"
      SelfCareApiKey                    = module.key_vault_secrets.values["SelfCareApiKey"].value
      LollipopApiBasePath               = "https://api.io.pagopa.it"
      LollipopApiKey                    = module.key_vault_secrets.values["LollipopPrimaryApiKey"].value
      SlackWebhookUrl                   = module.key_vault_secrets.values["SlackWebhookUrl"].value
      IoLinkBaseUrl                     = "https://continua.io.pagopa.it"
    }
  }
}

module "io_sign_user_func" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v8.35.0"

  name                = format("%s-user-func", local.project)
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  health_check_path = "/api/v1/sign/info"

  node_version    = "18"
  runtime_version = "~4"
  always_on       = true

  app_service_plan_info = {
    kind                         = "Linux"
    sku_size                     = var.io_sign_user_func.sku_size
    maximum_elastic_worker_count = 0
    worker_count                 = 1
    zone_balancing_enabled       = false
  }

  app_settings = merge(
    local.io_sign_user_func.app_settings,
    {
      # Enable functions on production triggered by queue and timer
      for to_disable in local.io_sign_user_func.staging_disabled :
      format("AzureWebJobs.%s.Disabled", to_disable) => "false"
    }
  )

  sticky_app_setting_names = [
    # Sticky the settings enabling triggered by queue and timer
    for to_disable in local.io_sign_user_func.staging_disabled :
    format("AzureWebJobs.%s.Disabled", to_disable)
  ]

  subnet_id = module.io_sign_user_snet.id
  allowed_subnets = [
    module.io_sign_user_snet.id,
  ]

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  system_identity_enabled                  = true

  tags = var.tags
}

module "io_sign_user_func_staging_slot" {
  count  = var.io_sign_user_func.sku_tier == "PremiumV3" ? 1 : 0
  source = "github.com/pagopa/terraform-azurerm-v3//function_app_slot?ref=v8.35.0"

  name                = "staging"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
  function_app_id     = module.io_sign_user_func.id
  app_service_plan_id = module.io_sign_user_func.app_service_plan_id

  health_check_path            = "/api/v1/sign/info"
  health_check_maxpingfailures = 2

  storage_account_name       = module.io_sign_user_func.storage_account.name
  storage_account_access_key = module.io_sign_user_func.storage_account.primary_access_key

  node_version                             = "18"
  runtime_version                          = "~4"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.io_sign_user_func.app_settings,
    {
      # Disabled functions on slot triggered by queue and timer
      for to_disable in local.io_sign_user_func.staging_disabled :
      format("AzureWebJobs.%s.Disabled", to_disable) => "true"
    }
  )

  subnet_id = module.io_sign_user_snet.id
  allowed_subnets = [
    module.io_sign_user_snet.id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "io_sign_user_func" {
  count               = var.io_sign_user_func.sku_tier == "PremiumV3" ? 1 : 0
  name                = format("%s-autoscale", module.io_sign_user_func.name)
  resource_group_name = azurerm_resource_group.backend_rg.name
  location            = azurerm_resource_group.backend_rg.location
  target_resource_id  = module.io_sign_user_func.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.io_sign_user_func.autoscale_default
      minimum = var.io_sign_user_func.autoscale_minimum
      maximum = var.io_sign_user_func.autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.io_sign_user_func.id
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
        metric_resource_id       = module.io_sign_user_func.app_service_plan_id
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
        metric_resource_id       = module.io_sign_user_func.id
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
        metric_resource_id       = module.io_sign_user_func.app_service_plan_id
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

  tags = var.tags
}
