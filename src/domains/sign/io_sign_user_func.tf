locals {
  user_func_name      = format("%s-user-func", local.project)
  user_func_container = "src"
  user_func_package   = format("https://%sst.blob.core.windows.net/%s/%s.zip", replace(local.user_func_name, "-", ""), local.user_func_container, var.io_sign_user_func.version)
}

module "io_sign_user_func" {
  source    = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.18.2"
  name      = local.user_func_name
  subnet_id = module.io_sign_user_snet.id

  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
  app_service_plan_info = {
    kind                         = "Linux"
    sku_tier                     = var.io_sign_user_func.sku_tier
    sku_size                     = var.io_sign_user_func.sku_size
    maximum_elastic_worker_count = 1
  }

  os_type           = "linux"
  always_on         = true
  linux_fx_version  = "NODE|16"
  health_check_path = "api/v1/sign/info"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME                        = "node"
    WEBSITE_NODE_DEFAULT_VERSION                    = "16.13.0"
    WEBSITE_VNET_ROUTE_ALL                          = "1"
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_DNS_SERVER                              = "168.63.129.16"
    WEBSITE_RUN_FROM_PACKAGE                        = local.user_func_package
    AzureWebJobsDisableHomepage                     = "true"
    CosmosDbConnectionString                        = module.cosmosdb_account.connection_strings[0]
    CosmosDbDatabaseName                            = module.cosmosdb_sql_database_issuer.name
    StorageAccountConnectionString                  = module.io_sign_storage.primary_connection_string
    IssuerUploadedBlobContainerName                 = azurerm_storage_container.uploaded_documents.name
    IssuerValidatedBlobContainerName                = azurerm_storage_container.validated_documents.name
    WaitingMessageQueueName                         = azurerm_storage_queue.waiting_message.name
    IOApiBasePath                                   = "https://api.io.pagopa.it/api/v1/messages"
    IOApiSubscriptionKey                            = module.key_vault_secrets.values["IOApiSubscriptionKey"].value
    IOApiRequestTimeout                             = 10000
    PdvTokenizerApiBasePath                         = "https://api.tokenizer.pdv.pagopa.it/"
    PdvTokenizerApiKey                              = module.key_vault_secrets.values["TokenizerApiSubscriptionKey"].value
  }

  allowed_subnets = [module.io_sign_user_snet.id]
  allowed_ips     = local.app_insights_ips_west_europe

  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  tags = var.tags
}

resource "azurerm_storage_container" "io_sign_user_func_container" {
  name                  = local.user_func_container
  storage_account_name  = module.io_sign_user_func.storage_account_name
  container_access_type = "private"
}
