resource "azurerm_resource_group" "service_messages_rg" {
  name     = format("%s-service-messages-rg", local.product)
  location = var.location
  tags     = var.tags
}

data "azurerm_storage_account" "services_storage" {
  name                = "iopmessagesweuprod01svst"
  resource_group_name = "io-p-messages-weu-prod01-data-process-rg"
}

data "azurerm_key_vault_secret" "appbackendli_token" {
  name         = "appbackendli-token"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "internal_user" {
  name         = "internal-user-id-to-skip"
  key_vault_id = data.azurerm_key_vault.kv.id
}

locals {
  function_service_messages = {
    app_settings = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_DNS_SERVER             = "168.63.129.16"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      APPINSIGHTS_INSTRUMENTATIONKEY            = data.azurerm_application_insights.application_insights.instrumentation_key
      MESSAGE_CONTENT_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.storage_api.primary_connection_string

      BACKEND_BASE_URL = "https://io-p-app-appbackendli.azurewebsites.net"
      BACKEND_TOKEN    = data.azurerm_key_vault_secret.appbackendli_token.value

      QueueStorageConnection                       = data.azurerm_storage_account.services_storage.primary_connection_string
      NOTIFICATION_QUEUE_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.push_notifications_storage.primary_connection_string
      NOTIFICATION_QUEUE_NAME                      = "push-notifications"

      COSMOSDB_NAME              = "db"
      COSMOSDB_URI               = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY               = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOSDB_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_api.endpoint, data.azurerm_cosmosdb_account.cosmos_api.primary_key)

      MESSAGE_CONTAINER_NAME = "message-content"

      REMOTE_CONTENT_COSMOSDB_URI               = data.azurerm_cosmosdb_account.cosmos_remote_content.endpoint
      REMOTE_CONTENT_COSMOSDB_KEY               = data.azurerm_cosmosdb_account.cosmos_remote_content.primary_key
      REMOTE_CONTENT_COSMOSDB_NAME              = "remote-content"
      REMOTE_CONTENT_COSMOSDB_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_remote_content.endpoint, data.azurerm_cosmosdb_account.cosmos_remote_content.primary_key)

      MESSAGE_CONFIGURATION_CHANGE_FEED_LEASE_PREFIX = "RemoteContentMessageConfigurationChangeFeed-00"
      MESSAGE_CONFIGURATION_CHANGE_FEED_START_TIME   = "0"

      // REDIS
      REDIS_URL      = data.azurerm_redis_cache.redis_messages.hostname
      REDIS_PORT     = data.azurerm_redis_cache.redis_messages.ssl_port
      REDIS_PASSWORD = data.azurerm_redis_cache.redis_messages.primary_access_key

      INTERNAL_USER_ID           = data.azurerm_key_vault_secret.internal_user.value
      RC_CONFIGURATION_CACHE_TTL = "28800"

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

module "function_service_messages_snet" {
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.70.1"

  name                                      = format("%s-fn-service-messages-snet", local.product)
  address_prefixes                          = var.cidr_subnet_fnservicemessages
  resource_group_name                       = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet_common.name
  private_endpoint_network_policies_enabled = false

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

module "function_service_messages" {
  count  = var.function_service_messages_enabled ? 1 : 0
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v7.70.1"

  resource_group_name = azurerm_resource_group.service_messages_rg.name
  name                = format("%s-service-messages-fn", local.product)
  location            = azurerm_resource_group.service_messages_rg.location
  health_check_path   = "/api/v1/info"
  domain              = "MESSAGES"

  node_version                             = "18"
  runtime_version                          = "~4"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = "Linux"
    sku_tier                     = "PremiumV3"
    sku_size                     = "P1v3"
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = false
  }

  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "GZRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    use_legacy_defender_version       = true
  }

  app_settings = merge(
    local.function_service_messages.app_settings,
  )

  subnet_id = module.function_service_messages_snet.id

  allowed_subnets = [
    module.function_service_messages_snet.id,
    data.azurerm_subnet.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = null
    }
  ]

  client_certificate_mode = "Required"

  tags = var.tags
}

module "function_service_messages_staging_slot" {
  count  = var.function_service_messages_enabled ? 1 : 0
  source = "github.com/pagopa/terraform-azurerm-v3//function_app_slot?ref=v7.70.1"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.service_messages_rg.name
  function_app_id     = module.function_service_messages[0].id
  app_service_plan_id = module.function_service_messages[0].app_service_plan_id
  health_check_path   = "/api/v1/info"

  node_version                             = "18"
  runtime_version                          = "~4"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  storage_account_name       = module.function_service_messages[0].storage_account.name
  storage_account_access_key = module.function_service_messages[0].storage_account.primary_access_key

  app_settings = merge(
    local.function_service_messages.app_settings,
  )

  subnet_id = module.function_service_messages_snet.id

  allowed_subnets = [
    module.function_service_messages_snet.id,
    data.azurerm_subnet.azdoa_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_service_messages" {
  count               = var.function_service_messages_enabled ? 1 : 0
  name                = format("%s-autoscale", module.function_service_messages[0].name)
  resource_group_name = azurerm_resource_group.service_messages_rg.name
  location            = var.location
  target_resource_id  = module.function_service_messages[0].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = 1
      minimum = 1
      maximum = 30
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_service_messages[0].id
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
        metric_resource_id       = module.function_service_messages[0].app_service_plan_id
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
        metric_resource_id       = module.function_service_messages[0].id
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
        metric_resource_id       = module.function_service_messages[0].app_service_plan_id
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
