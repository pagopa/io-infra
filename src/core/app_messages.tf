data "azurerm_key_vault_secret" "fn_messages_APP_MESSAGES_BETA_FISCAL_CODES" {
  name         = "appbackend-APP-MESSAGES-BETA-FISCAL-CODES"
  key_vault_id = data.azurerm_key_vault.common.id
}

locals {
  function_app_messages = {
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

      MESSAGE_CONTAINER_NAME = local.message_content_container_name
      QueueStorageConnection = data.azurerm_storage_account.api.primary_connection_string

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      // REDIS
      REDIS_URL      = module.redis_messages.hostname
      REDIS_PORT     = module.redis_messages.ssl_port
      REDIS_PASSWORD = module.redis_messages.primary_access_key

      PN_SERVICE_ID = var.pn_service_id

      // View Features Flag
      USE_FALLBACK          = false
      FF_TYPE               = "beta"
      FF_BETA_TESTER_LIST   = data.azurerm_key_vault_secret.fn_messages_APP_MESSAGES_BETA_FISCAL_CODES.value
      FF_CANARY_USERS_REGEX = "XYZ"

    }
    app_settings_1 = {
    }
    app_settings_2 = {
    }
  }
}

module "redis_messages" {
  source                = "git::https://github.com/pagopa/terraform-azurerm-v3.git//redis_cache?ref=v4.1.9"
  name                  = format("%s-redis-app-messages-std", local.project)
  resource_group_name   = azurerm_resource_group.app_messages_common_rg.name
  location              = azurerm_resource_group.app_messages_common_rg.location
  capacity              = 0
  family                = "C"
  sku_name              = "Standard"
  enable_authentication = true

  // when azure can apply patch?
  patch_schedules = [{
    day_of_week    = "Sunday"
    start_hour_utc = 23
    },
    {
      day_of_week    = "Monday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Tuesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Wednesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Thursday"
      start_hour_utc = 23
    },
  ]


  private_endpoint = {
    enabled              = true
    virtual_network_id   = data.azurerm_virtual_network.vnet_common.id
    subnet_id            = data.azurerm_subnet.private_endpoints_subnet.id
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_redis_cache.id]
  }

  tags = var.tags
}

resource "azurerm_resource_group" "app_messages_common_rg" {
  name     = format("%s-app-messages-common-rg", local.project)
  location = var.location

  tags = var.tags
}
resource "azurerm_resource_group" "app_messages_rg" {
  count    = var.app_messages_count
  name     = format("%s-app-messages-rg-%d", local.project, count.index + 1)
  location = var.location

  tags = var.tags
}

# Subnet to host app messages function
module "app_messages_snet" {
  count                                          = var.app_messages_count
  source                                         = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.9"
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

#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "app_messages_function" {
  count  = var.app_messages_count
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v4.1.9"

  resource_group_name = azurerm_resource_group.app_messages_rg[count.index].name
  name                = format("%s-app-messages-fn-%d", local.project, count.index + 1)
  domain              = "MESSAGES"
  location            = var.location
  health_check_path   = "/api/v1/info"

  os_type                                  = "linux"
  runtime_version                          = "~4"
  linux_fx_version                         = "NODE|14"
  always_on                                = var.app_messages_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.app_messages_function_kind
    sku_tier                     = var.app_messages_function_sku_tier
    sku_size                     = var.app_messages_function_sku_size
    maximum_elastic_worker_count = 0
  }

  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }

  app_settings = merge(
    local.function_app_messages.app_settings_common,
  )

  subnet_id = module.app_messages_snet[count.index].id

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

  # Action groups for alerts
  action = [
    {
      action_group_id    = azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}

module "app_messages_function_staging_slot" {
  count  = var.app_messages_count
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v4.1.9"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.app_messages_rg[count.index].name
  function_app_name   = module.app_messages_function[count.index].name
  function_app_id     = module.app_messages_function[count.index].id
  app_service_plan_id = module.app_messages_function[count.index].app_service_plan_id
  health_check_path   = "/api/v1/info"

  storage_account_name       = module.app_messages_function[count.index].storage_account.name
  storage_account_access_key = module.app_messages_function[count.index].storage_account.primary_access_key

  os_type                                  = "linux"
  runtime_version                          = "~4"
  linux_fx_version                         = "NODE|14"
  always_on                                = var.app_messages_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_app_messages.app_settings_common,
  )

  subnet_id = module.app_messages_snet[count.index].id

  allowed_subnets = [
    module.app_messages_snet[count.index].id,
    module.app_backendl1_snet.id,
    module.app_backendl2_snet.id,
    data.azurerm_subnet.azdoa_snet[0].id,
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
