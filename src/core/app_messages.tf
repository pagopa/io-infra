resource "azurerm_resource_group" "io-p-app-messages-rg-01" {
  count    = var.app_messages_enabled ? 1 : 0
  name     = format("%s-io-p-app-messages-rg-01", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "io-p-app-messages-rg-02" {
  count    = var.app_messages_enabled ? 1 : 0
  name     = format("%s-io-p-app-messages-rg-02", local.project)
  location = var.location

  tags = var.tags
}

locals {
  app_messages = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      COSMOSDB_NAME                = "db"
      COSMOSDB_URI                 = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY                 = data.azurerm_cosmosdb_account.cosmos_api.primary_master_key
      COSMOS_API_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_api.endpoint, data.azurerm_cosmosdb_account.cosmos_api.primary_master_key)

      QueueStorageConnection = dependency.storage_account.outputs.primary_connection_string
      MESSAGE_CONTAINER_NAME = dependency.storage_container_message-content.outputs.name

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      FN_APP_STORAGE_CONNECTION_STRING = dependency.storage_account_app.outputs.primary_connection_string

      // Events configs
      EventsQueueStorageConnection = dependency.storage_account_apievents.outputs.primary_connection_string
      EventsQueueName              = "events" # reference to https://github.com/pagopa/io-infra/blob/12a2f3bffa49dab481990fccc9f2a904004862ec/src/core/storage_apievents.tf#L7
    }
    app_settings_01 = {

    }
    app_settings_02 = {
    }
  }
}

# Subnet to host app messages function
module "io-p-app-messages_01_snet" {
  count                                          = var.app_messages_enabled && var.cidr_subnet_appmessages01 != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-io-p-app-messages_01_snet", local.project)
  address_prefixes                               = var.cidr_subnet_appmessages01
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
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

module "io-p-app-messages_02_snet" {
  count                                          = var.app_messages_enabled && var.cidr_subnet_appmessages02 != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-io-p-app-messages_02_snet", local.project)
  address_prefixes                               = var.cidr_subnet_appmessages02
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
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

module "app_messages_function_01" {
  count  = var.app_messages_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.2.0"

  resource_group_name = azurerm_resource_group.io-p-app-messages_01_snet[0].name
  name                = format("%s-io-p-app-messages01", local.project)
  location            = var.location
  health_check_path   = "info"
  subnet_id           = module.io-p-app-messages_01_snet[0].id
  runtime_version     = "~3"
  os_type             = "linux"

  always_on                                = var.app_messages_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_name = format("%s-plan-fnmessages01", local.project)
  app_service_plan_info = {
    kind                         = var.app_messages_function_kind
    sku_tier                     = var.app_messages_function_sku_tier
    sku_size                     = var.app_messages_function_sku_size
    maximum_elastic_worker_count = 0
  }


  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "app_messages_function_01" {
  count = var.app_messages_enabled && var.env_short != "d" ? 1 : 0

  name                = format("%s-autoscale", module.app_messages_function_01[0].name)
  resource_group_name = azurerm_resource_group.io-p-app-messages_01_snet[0].name
  location            = var.location
  target_resource_id  = module.app_messages_function_01[0].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.app_messages_function_autoscale_default
      minimum = var.app_messages_function_autoscale_minimum
      maximum = var.app_messages_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_messages_function_01[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
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
        metric_resource_id       = module.app_messages_function_01[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 3000
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

module "app_messages_function_02" {
  count  = var.app_messages_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.2.0"

  resource_group_name = azurerm_resource_group.io-p-app-messages_02_snet[0].name
  name                = format("%s-io-p-app-messages02", local.project)
  location            = var.location
  health_check_path   = "info"
  subnet_id           = module.io-p-app-messages_02_snet[0].id
  runtime_version     = "~3"
  os_type             = "linux"

  always_on                                = var.app_messages_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_name = format("%s-plan-fnmessages02", local.project)
  app_service_plan_info = {
    kind                         = var.app_messages_function_kind
    sku_tier                     = var.app_messages_function_sku_tier
    sku_size                     = var.app_messages_function_sku_size
    maximum_elastic_worker_count = 0
  }

  storage_account_name = replace(format("%s-st-fnmessages02", local.project), "-", "")

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "app_messages_function_02" {
  count = var.app_messages_enabled && var.env_short != "d" ? 1 : 0

  name                = format("%s-autoscale", module.app_messages_function_02[0].name)
  resource_group_name = azurerm_resource_group.io-p-app-messages_02_snet[0].name
  location            = var.location
  target_resource_id  = module.app_messages_function_02[0].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.app_messages_function_autoscale_default
      minimum = var.app_messages_function_autoscale_minimum
      maximum = var.app_messages_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_messages_function_02[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
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
        metric_resource_id       = module.app_messages_function_02[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 3000
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

