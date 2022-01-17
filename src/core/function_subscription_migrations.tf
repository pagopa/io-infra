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
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=add-fn-os_type"

  name                = format("%s-subsmigrations-fn", local.project)
  location            = local.function_subscriptionmigrations.app_context.resource_group.location
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  app_service_plan_id = local.function_subscriptionmigrations.app_context.app_service_plan.id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

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

  runtime_version   = "~3"
  os_type           = "linux"
  health_check_path = "api/v1/info"

  subnet_id   = local.function_subscriptionmigrations.app_context.snet.id
  allowed_ips = local.app_insights_ips_west_europe
  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  app_settings = merge(local.function_subscriptionmigrations.app_settings_commons, {})

  tags = var.tags
}


module "function_subscriptionmigrations_staging_slot" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=add-fn-os_type"

  name                = "staging"
  location            = local.function_subscriptionmigrations.app_context.resource_group.location
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  function_app_name   = module.function_subscriptionmigrations.name
  app_service_plan_id = local.function_subscriptionmigrations.app_context.app_service_plan.id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  storage_account_name               = module.function_subscriptionmigrations.storage_account_name
  storage_account_access_key         = module.function_subscriptionmigrations.storage_account.primary_access_key
  internal_storage_connection_string = module.function_subscriptionmigrations.storage_account_internal_function.primary_connection_string

  runtime_version   = "~3"
  os_type           = "linux"
  health_check_path = "api/v1/info"

  subnet_id   = local.function_subscriptionmigrations.app_context.snet.id
  allowed_ips = concat(
    [],
  )
  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  app_settings = merge(local.function_subscriptionmigrations.app_settings_commons, {})

  tags = var.tags
}
