locals {
  function_subscriptionmigrations = {
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

    // As we run this application under SelfCare IO logic subdomain, 
    //  we share some resources
    app_context = {
      resource_group   = azurerm_resource_group.selfcare_be_rg
      app_service_plan = azurerm_app_service_plan.selfcare_be_common
      snet             = module.selfcare_be_common_snet
    }
  }

}

module "function_subscriptionmigrations" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.1.0"

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  location                                 = var.location
  name                                     = format("%s-subsmigrations-fn", local.project)
  resource_group_name                      = local.function_subscriptionmigrations.app_context.resource_group.name
  subnet_id                                = local.function_subscriptionmigrations.app_context.snet.id
  tags                                     = var.tags
  allowed_ips                              = local.app_insights_ips_west_europe
  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  app_service_plan_id = local.function_subscriptionmigrations.app_context.app_service_plan.id
  health_check_path   = "api/v1/info"
  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 1,
  }

  runtime_version = "~3"

  app_settings = merge(local.function_subscriptionmigrations.app_settings_commons, {})

}

module "function_subscriptionmigrations_staging_slot" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v2.1.0"

  app_service_plan_sku                       = local.function_subscriptionmigrations.app_context.app_service_plan.sku
  application_insights_instrumentation_key   = data.azurerm_application_insights.application_insights.instrumentation_key
  durable_function_storage_connection_string = module.function_subscriptionmigrations.storage_account_internal_function.value.primary_connection_string
  function_app_name                          = module.function_subscriptionmigrations.storage_account_internal_function.value.name
  location                                   = var.location
  name                                       = "staging"
  resource_group_name                        = local.function_subscriptionmigrations.app_context.resource_group.name
  subnet_id                                  = local.function_subscriptionmigrations.app_context.snet.id
  tags                                       = var.tags

  allowed_ips = local.app_insights_ips_west_europe
  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  app_service_plan_id = local.function_subscriptionmigrations.app_context.app_service_plan.id
  health_check_path   = "api/v1/info"

  runtime_version = "~3"

  app_settings = merge(local.function_subscriptionmigrations.app_settings_commons, {})

  storage_account_name = module.function_subscriptionmigrations.storage_account_name

}
