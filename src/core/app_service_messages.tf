locals {
  function_app_service_messages = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_VNET_ROUTE_ALL         = "1"
      WEBSITE_DNS_SERVER             = "168.63.129.16"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      COSMOSDB_NAME                = "db"
      COSMOSDB_URI                 = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY                 = data.azurerm_cosmosdb_account.cosmos_api.primary_master_key
      COSMOS_API_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_api.endpoint, data.azurerm_cosmosdb_account.cosmos_api.primary_master_key)

      MESSAGE_CONTAINER_NAME = "message-content"
      QueueStorageConnection = data.azurerm_storage_account.api.primary_connection_string

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

    }
  }
}

resource "azurerm_resource_group" "app_service_messages_common_rg" {
  name     = format("%s-app-service-messages-common-rg", local.project)
  location = var.location

  tags = var.tags
}


# Subnet to host app service messages function
module "app_service_messages_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-app-service-messages-snet", local.project)
  address_prefixes                               = [var.cidr_subnet_appservicemessages]
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true

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

module "app_service_messages_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.3.1"

  resource_group_name = azurerm_resource_group.app_service_messages_common_rg.name
  name                = format("%s-app-service-messages-fn", local.project)
  location            = var.location
  health_check_path   = "api/v1/info"

  os_type                                  = "linux"
  always_on                                = var.app_service_messages_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.app_service_messages_function_kind
    sku_tier                     = var.app_service_messages_function_sku_tier
    sku_size                     = var.app_service_messages_function_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = merge(
    local.function_app_service_messages.app_settings_common,
  )

  subnet_id = module.app_service_messages_snet.id

  allowed_subnets = [
    module.app_service_messages_snet.id,
    module.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  tags = var.tags
}

module "app_service_messages_function_staging_slot" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v2.3.1"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.app_service_messages_common_rg.name
  function_app_name   = module.app_service_messages_function.name
  function_app_id     = module.app_service_messages_function.id
  app_service_plan_id = module.app_service_messages_function.app_service_plan_id
  health_check_path   = "api/v1/info"

  storage_account_name       = module.app_service_messages_function.storage_account.name
  storage_account_access_key = module.app_service_messages_function.storage_account.primary_access_key

  os_type                                  = "linux"
  always_on                                = var.app_service_messages_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_app_service_messages.app_settings_common,
  )

  subnet_id = module.app_service_messages_snet.id

  allowed_subnets = [
    module.app_service_messages_snet.id,
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  allowed_ips = concat(
    [],
  )

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "app_service_messages_function" {
  name                = format("%s-autoscale", module.app_service_messages_function.name)
  resource_group_name = azurerm_resource_group.app_service_messages_common_rg.name
  location            = var.location
  target_resource_id  = module.app_service_messages_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.app_service_messages_function_autoscale_default
      minimum = var.app_service_messages_function_autoscale_minimum
      maximum = var.app_service_messages_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_service_messages_function.id
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
        metric_resource_id       = module.app_service_messages_function.app_service_plan_id
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
        metric_resource_id       = module.app_service_messages_function.id
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
        metric_resource_id       = module.app_service_messages_function.app_service_plan_id
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
