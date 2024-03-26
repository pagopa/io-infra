data "azurerm_key_vault_secret" "fn_messages_APP_MESSAGES_BETA_FISCAL_CODES" {
  name         = "appbackend-APP-MESSAGES-BETA-FISCAL-CODES"
  key_vault_id = data.azurerm_key_vault.kv_common.id
}

data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.product)
  resource_group_name = format("%s-rg-internal", local.product)
}

data "azurerm_cosmosdb_account" "cosmos_remote_content" {
  name                = "${local.product}-messages-remote-content"
  resource_group_name = "${local.product}-messages-data-rg"
}

data "azurerm_storage_account" "storage_api" {
  name                = replace("${local.product}stapi", "-", "")
  resource_group_name = format("%s-rg-internal", local.product)
}

data "azurerm_redis_cache" "redis_messages" {
  name                = "${local.product}-redis-app-messages-std-v6"
  resource_group_name = "${local.product}-app-messages-common-rg"
}

locals {
  function_app_messages = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_DNS_SERVER             = "168.63.129.16"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      COSMOSDB_NAME                = "db"
      COSMOSDB_URI                 = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY                 = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOS_API_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_api.endpoint, data.azurerm_cosmosdb_account.cosmos_api.primary_key)

      // Remote Content CosmosDB
      REMOTE_CONTENT_COSMOSDB_NAME = "remote-content"
      REMOTE_CONTENT_COSMOSDB_URI  = data.azurerm_cosmosdb_account.cosmos_remote_content.endpoint
      REMOTE_CONTENT_COSMOSDB_KEY  = data.azurerm_cosmosdb_account.cosmos_remote_content.primary_key

      // Service to Remote Content configuration MAP
      SERVICE_TO_RC_CONFIGURATION_MAP = jsonencode({
        "${var.pn_service_id}"               = var.pn_remote_config_id,
        "${var.io_sign_service_id}"          = var.io_sign_remote_config_id,
        "${var.io_receipt_service_test_id}"  = var.io_receipt_remote_config_test_id,
        "${var.io_receipt_service_id}"       = var.io_receipt_remote_config_id,
        "${var.third_party_mock_service_id}" = var.third_party_mock_remote_config_id
      })

      MESSAGE_CONTAINER_NAME = "message-content"
      QueueStorageConnection = data.azurerm_storage_account.storage_api.primary_connection_string

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      // REDIS
      REDIS_URL      = data.azurerm_redis_cache.redis_messages.hostname
      REDIS_PORT     = data.azurerm_redis_cache.redis_messages.ssl_port
      REDIS_PASSWORD = data.azurerm_redis_cache.redis_messages.primary_access_key

      // CACHE TTLs
      SERVICE_CACHE_TTL_DURATION = "28800" // 8 hours

      PN_SERVICE_ID = var.pn_service_id

      // View Features Flag
      USE_FALLBACK        = false
      FF_TYPE             = "canary"
      FF_BETA_TESTER_LIST = data.azurerm_key_vault_secret.fn_messages_APP_MESSAGES_BETA_FISCAL_CODES.value
      # Takes ~0,4% of users
      FF_CANARY_USERS_REGEX = "^([(0-9)|(a-f)|(A-F)]{62}00)$"

    }
    app_settings_1 = {
    }
    app_settings_2 = {
    }
  }
}

resource "azurerm_resource_group" "app_messages_rg" {
  count = var.app_messages_count

  name     = format("%s-app-messages-rg-%d", local.product, count.index + 1)
  location = var.location

  tags = var.tags
}

module "app_messages_snet" {
  count  = var.app_messages_count
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v7.69.1"

  name                                      = format("%s-app-messages-snet-%d", local.product, count.index + 1)
  address_prefixes                          = [var.cidr_subnet_appmessages[count.index]]
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

module "app_messages_function" {
  count  = var.app_messages_count
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v7.69.1"

  resource_group_name = azurerm_resource_group.app_messages_rg[count.index].name
  name                = format("%s-app-messages-fn-%d", local.product, count.index + 1)
  domain              = "MESSAGES"
  location            = azurerm_resource_group.app_messages_rg[count.index].location
  health_check_path   = "/api/v1/info"

  runtime_version                          = "~4"
  node_version                             = "18"
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
    local.function_app_messages.app_settings_common,
  )

  subnet_id = module.app_messages_snet[count.index].id

  allowed_subnets = [
    module.app_messages_snet[count.index].id,
    data.azurerm_subnet.app_backendl1_snet.id,
    data.azurerm_subnet.app_backendl2_snet.id,
    data.azurerm_subnet.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  client_certificate_mode = "Required"

  tags = var.tags
}

module "app_messages_function_staging_slot" {
  count  = var.app_messages_count
  source = "github.com/pagopa/terraform-azurerm-v3//function_app_slot?ref=v7.69.1"

  name                = "staging"
  location            = azurerm_resource_group.app_messages_rg[count.index].location
  resource_group_name = azurerm_resource_group.app_messages_rg[count.index].name
  function_app_id     = module.app_messages_function[count.index].id
  app_service_plan_id = module.app_messages_function[count.index].app_service_plan_id
  health_check_path   = "/api/v1/info"

  storage_account_name       = module.app_messages_function[count.index].storage_account.name
  storage_account_access_key = module.app_messages_function[count.index].storage_account.primary_access_key

  os_type                                  = "linux"
  runtime_version                          = "~4"
  node_version                             = "18"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_app_messages.app_settings_common,
  )

  subnet_id = module.app_messages_snet[count.index].id

  allowed_subnets = [
    module.app_messages_snet[count.index].id,
    data.azurerm_subnet.app_backendl1_snet.id,
    data.azurerm_subnet.app_backendl2_snet.id,
    data.azurerm_subnet.azdoa_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "app_messages_function" {
  count               = var.app_messages_count
  name                = format("%s-autoscale", module.app_messages_function[count.index].name)
  resource_group_name = azurerm_resource_group.app_messages_rg[count.index].name
  location            = azurerm_resource_group.app_messages_rg[count.index].location
  target_resource_id  = module.app_messages_function[count.index].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = 10
      minimum = 1
      maximum = 15
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
        threshold                = 3000
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
        metric_resource_id       = module.app_messages_function[count.index].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 45
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
        threshold                = 2000
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
        metric_resource_id       = module.app_messages_function[count.index].app_service_plan_id
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
