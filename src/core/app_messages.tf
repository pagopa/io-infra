locals {
  app_messages = {
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
    app_settings_01 = {
    }
    app_settings_02 = {
    }
  }
}

resource "azurerm_resource_group" "app_messages_rg" {
  count    = var.app_messages_count
  name     = format("%s-app-messages-rg-%d", local.project, count.index + 1)
  location = var.location

  tags = var.tags
}

# resource "azurerm_container_registry" "container_registry" {
#   name                = replace(format("%s-acr", local.project), "-", "")
#   resource_group_name = azurerm_resource_group.rg_internal.name
#   location            = azurerm_resource_group.rg_internal.location
#   sku                 = var.sku_container_registry
#   admin_enabled       = true


#   dynamic "retention_policy" {
#     for_each = var.sku_container_registry == "Premium" ? [var.retention_policy_acr] : []
#     content {
#       days    = retention_policy.value["days"]
#       enabled = retention_policy.value["enabled"]
#     }
#   }

#   tags = var.tags
# }

# Subnet to host app messages function
module "app_messages_snet" {
  count                                          = var.app_messages_count
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-app-messages-snet-%d", local.project, count.index + 1)
  address_prefixes                               = [var.cidr_subnet_appmessages[count.index]]
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

module "app_messages_function" {
  count  = 2
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.3.1"

  resource_group_name = azurerm_resource_group.app_messages_rg[count.index].name
  name                = format("%s-app-messages-fn-%d", local.project, count.index + 1)
  location            = var.location
  health_check_path   = "api/v1/info"
  subnet_id           = module.app_messages_snet[count.index].id

  # linux_fx_version = format("DOCKER|%s/app-messages-fn:%s",
  # azurerm_container_registry.container_registry.login_server, "latest")

  os_type                                  = "linux"
  always_on                                = var.app_messages_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  # App service plan
  # plan_type     = "internal"
  # plan_name     = format("%s-plan-app-messages-fn-%d", local.project, count.index + 1)
  # plan_kind     = var.app_messages_function_kind
  # plan_reserved = true # Mandatory for Linux plan
  # plan_sku_tier = var.app_messages_function_sku_tier
  # plan_sku_size = var.app_messages_function_sku_size

  app_service_plan_info = {
    kind                         = var.app_messages_function_kind
    sku_tier                     = var.app_messages_function_sku_tier
    sku_size                     = var.app_messages_function_sku_size
    maximum_elastic_worker_count = 0
  }

  allowed_subnets = [
    module.app_messages_snet[count.index].id,
    module.app_backendl1_snet.id,
    module.app_backendl2_snet.id,
    module.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "app_messages_function" {
  count               = var.app_messages_count
  name                = format("%s-autoscale", module.app_messages_function[count.index].name)
  resource_group_name = azurerm_resource_group.app_messages_rg[count.index].name
  location            = var.location
  target_resource_id  = module.app_messages_function[count.index].app_service_plan_id

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
        metric_resource_id       = module.app_messages_function[count.index].id
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
        metric_resource_id       = module.app_messages_function[count.index].id
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
