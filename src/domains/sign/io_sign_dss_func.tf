data "azurerm_key_vault_secret" "cosmosdb_connection_string" {
  name         = "CosmosDbConnectionString"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "io_api_subscription_key" {
  name         = "IOApiSubscriptionKey"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "storage_account_connection_string" {
  name         = "StorageAccountConnectionString"
  key_vault_id = module.key_vault.id
}

module "io_sign_dss_func" {
  source    = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.18.2"
  name      = "${local.project}-dss-func"
  subnet_id = module.io_sign_snet.id

  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
  app_service_plan_info = {
    kind                         = "Linux"
    sku_tier                     = var.io_sign_dss_func.sku_tier
    sku_size                     = var.io_sign_dss_func.sku_size
    maximum_elastic_worker_count = 1
  }

  os_type           = "linux"
  always_on         = true
  linux_fx_version  = "JAVA|11-java11"
  health_check_path = "api/info"


  app_settings = {
    FUNCTIONS_WORKER_RUNTIME     = "java"
    WEBSITE_VNET_ROUTE_ALL       = "1"
    WEBSITE_DNS_SERVER           = "168.63.129.16"
    QueueStorageConnection       = data.azurerm_storage_account.api.primary_connection_string
    CosmosDbConnectionString     = data.azurerm_key_vault_secret.cosmosdb_connection_string.value
    IOApiSubscriptionKey         = data.azurerm_key_vault_secret.io_api_subscription_key.value
    StorageAccountConnectionString = data.azurerm_key_vault_secret.storage_account_connection_string.value
  }

  allowed_subnets = [module.io_sign_snet.id, data.azurerm_subnet.apim.id]

  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  tags                                     = var.tags
}
