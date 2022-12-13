locals {
  io_sign_user_func = {
    app_settings = {
      FUNCTIONS_WORKER_RUNTIME                        = "node"
      WEBSITE_VNET_ROUTE_ALL                          = "1"
      WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
      WEBSITE_DNS_SERVER                              = "168.63.129.16"
      WEBSITE_RUN_FROM_PACKAGE                        = "1"
      FUNCTIONS_WORKER_PROCESS_COUNT                  = 4
      AzureWebJobsDisableHomepage                     = "true"
      NODE_ENV                                        = "production"
      CosmosDbConnectionString                        = module.cosmosdb_account.connection_strings[0]
      CosmosDbDatabaseName                            = module.cosmosdb_sql_database_user.name
      StorageAccountConnectionString                  = module.io_sign_storage.primary_connection_string
      userUploadedBlobContainerName                   = azurerm_storage_container.uploaded_documents.name
      userValidatedBlobContainerName                  = azurerm_storage_container.validated_documents.name
      WaitingMessageQueueName                         = azurerm_storage_queue.waiting_message.name
      IoServicesApiBasePath                           = "https://api.io.pagopa.it"
      IoServicesSubscriptionKey                       = module.key_vault_secrets.values["IOApiSubscriptionKey"].value
      PdvTokenizerApiBasePath                         = "https://api.uat.tokenizer.pdv.pagopa.it"
      PdvTokenizerApiKey                              = module.key_vault_secrets.values["TokenizerApiSubscriptionKey"].value
      NamirialApiBasePath                             = "https://pagopa.demo.bit4id.org"
      NamirialUsername                                = "api"
      NamirialPassword                                = module.key_vault_secrets.values["NamirialPassword"].value
    }
  }
}

module "io_sign_user_func" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v3.3.1"

  name                = format("%s-user-func", local.project)
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  # Health check should not be enabled on Premium Functions
  # https://learn.microsoft.com/en-us/azure/app-service/monitor-instances-health-check?tabs=dotnet#limitations
  # health_check_path   = "/api/v1/sign/info"

  os_type          = "linux"
  runtime_version  = "~4"
  always_on        = true
  linux_fx_version = "NODE|16"

  app_service_plan_info = {
    kind                         = "Linux"
    sku_tier                     = var.io_sign_user_func.sku_tier
    sku_size                     = var.io_sign_user_func.sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = local.io_sign_user_func.app_settings

  subnet_id       = module.io_sign_user_snet.id
  allowed_subnets = [module.io_sign_user_snet.id]

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  system_identity_enabled                  = true

  tags = var.tags
}

module "io_sign_user_func_staging_slot" {
  count  = var.io_sign_user_func.sku_tier == "PremiumV3" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v3.4.0"

  name                = "staging"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
  function_app_name   = module.io_sign_user_func.name
  function_app_id     = module.io_sign_user_func.id
  app_service_plan_id = module.io_sign_user_func.app_service_plan_id

  # Health check should not be enabled on Premium Functions
  # https://learn.microsoft.com/en-us/azure/app-service/monitor-instances-health-check?tabs=dotnet#limitations
  # health_check_path   = "/api/v1/sign/info"

  storage_account_name       = module.io_sign_user_func.storage_account.name
  storage_account_access_key = module.io_sign_user_func.storage_account.primary_access_key

  os_type                                  = "linux"
  runtime_version                          = "~4"
  always_on                                = true
  linux_fx_version                         = "NODE|16"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = local.io_sign_user_func.app_settings

  subnet_id = module.io_sign_user_snet.id

  tags = var.tags
}
