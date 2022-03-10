module "fn_services_cache_subnet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.3.0"
  name                 = "${local.project}-services-cache-snet"
  address_prefixes     = var.cidr_subnet_fnservices_cache
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "function_services_cache" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.3.0"

  name = "${local.project}-services-cache-fn"
  # SELFCARE RG
  resource_group_name                      = azurerm_resource_group.selfcare_be_rg.name
  location                                 = var.location
  app_service_plan_id                      = azurerm_app_service_plan.selfcare_be_common.id
  health_check_path                        = "api/v1/info"
  subnet_id                                = module.fn_services_cache_subnet.id
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME     = "node"
    WEBSITE_NODE_DEFAULT_VERSION = "14.16.0"
    WEBSITE_RUN_FROM_PACKAGE     = "1"
    NODE_ENV                     = "production"

    COSMOSDB_URI                 = data.azurerm_cosmosdb_account.cosmos_api.endpoint
    COSMOSDB_KEY                 = data.azurerm_cosmosdb_account.cosmos_api.primary_master_key
    COSMOS_API_CONNECTION_STRING = "AccountEndpoint=${data.azurerm_cosmosdb_account.cosmos_api.endpoint};AccountKey=${data.azurerm_cosmosdb_account.cosmos_api.primary_master_key};"
    COSMOSDB_NAME                = "db"

    StorageConnection       = data.azurerm_storage_account.api.primary_web_endpoint
    AssetsStorageConnection = data.azurerm_storage_account.cdnassets.primary_web_endpoint

    // Disabled functions on slot function
    "AzureWebJobs.UpdateVisibleServicesCache.Disabled" = "0"

    SERVICEID_EXCLUSION_LIST = data.azurerm_key_vault_secret.services_exclusion_list.value
  }

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 0,
  }

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
    module.fn_services_cache_subnet.id
  ]

  allowed_ips = local.app_insights_ips_west_europe

  tags = var.tags
}
