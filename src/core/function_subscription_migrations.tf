module "function_subscriptionmigrations_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.1.0"
  name                 = format("%s-fn-sub-migrations-snet", local.project)
  address_prefixes     = var.cidr_subnet_selfcare_be
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

locals {
  app_settings_commons = {
    FUNCTIONS_WORKER_RUNTIME       = "node"
    WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4
    NODE_ENV                       = "production"

    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"
  }
}

module "function_subscriptionmigrations" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.1.0"

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  location                                 = var.location
  name                                     = "subscriptionmigrations"
  resource_group_name                      = azurerm_resource_group.selfcare_be_rg.name
  subnet_id                                = module.function_subscriptionmigrations_snet.id
  tags                                     = var.tags
  allowed_ips                              = local.app_insights_ips_west_europe
  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  app_service_plan_name = azurerm_app_service_plan.selfcare_be_common.name
  health_check_path     = "api/v1/info"
  internal_storage = object({
    "blobs_retention_days" : 1,
    "containers" : [],
    "enable" : true,
    "queues" : []
  })

  runtime_version = "~3"

  app_settings = merge(local.app_settings_commons, {})

}

module "function_subscriptionmigrations_staging_slot" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.1.0"

  app_service_plan_sku                       = azurerm_app_service_plan.selfcare_be_common.sku
  application_insights_instrumentation_key   = data.azurerm_application_insights.application_insights.instrumentation_key
  durable_function_storage_connection_string = function_subscriptionmigrations.storage_account_internal_function.value.primary_connection_string
  function_app_name                          = function_subscriptionmigrations.storage_account_internal_function.value.primary_connection_string
  location                                   = var.location
  name                                       = "staging"
  resource_group_name                        = azurerm_resource_group.selfcare_be_rg.name
  subnet_id                                  = module.function_subscriptionmigrations_snet.id
  tags                                       = var.tags

  allowed_ips = local.app_insights_ips_west_europe
  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  app_service_plan_name = azurerm_app_service_plan.selfcare_be_common.name
  health_check_path     = "api/v1/info"

  runtime_version = "~3"

  app_settings = merge(local.app_settings_commons, {})

}
