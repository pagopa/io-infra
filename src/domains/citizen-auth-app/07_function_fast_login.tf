data "azurerm_key_vault_secret" "fast_login_subscription_key" {
  name         = "fast-login-subscription-key-v2"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "backendli_api_key" {
  name         = "appbackend-PRE-SHARED-KEY"
  key_vault_id = data.azurerm_key_vault.kv_common.id
}

data "azurerm_app_service" "app_backend_li" {
  name                = format("%s-app-appbackendli", local.product)
  resource_group_name = format("%s-rg-linux", local.product)
}

locals {
  function_fast_login = {
    app_settings = {
      NODE_ENV = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      # COSMOS
      COSMOS_DB_NAME           = "citizen-auth"
      COSMOS_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_citizen_auth.endpoint, data.azurerm_cosmosdb_account.cosmos_citizen_auth.primary_key)

      // --------------------------
      //  Config for getAssertion
      // --------------------------
      LOLLIPOP_GET_ASSERTION_BASE_URL = "https://api.io.pagopa.it"
      LOLLIPOP_GET_ASSERTION_API_KEY  = data.azurerm_key_vault_secret.fast_login_subscription_key.value

      // --------------------------
      //  Fast login audit log storage
      // --------------------------
      FAST_LOGIN_AUDIT_CONNECTION_STRING = data.azurerm_storage_account.immutable_lv_audit_logs_storage.primary_connection_string


      // --------------------------
      //  Config for backendli connection
      // --------------------------
      BACKEND_INTERNAL_API_KEY  = data.azurerm_key_vault_secret.backendli_api_key.value
      BACKEND_INTERNAL_BASE_URL = "https://${data.azurerm_app_service.app_backend_li.default_site_hostname}"

    }
  }
}

resource "azurerm_resource_group" "fast_login_rg" {
  count    = var.fastlogin_enabled ? 1 : 0
  name     = format("%s-fast-login-rg", local.common_project)
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "fast_login_rg_itn" {
  name     = format("%s-fast-login-rg-01", local.common_project_itn)
  location = local.itn_location

  tags = var.tags
}

# Subnet to host admin function
module "fast_login_snet" {
  count                                     = var.fastlogin_enabled ? 1 : 0
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.22.0"
  name                                      = format("%s-fast-login-snet", local.common_project)
  address_prefixes                          = var.cidr_subnet_fnfastlogin
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

module "function_fast_login_itn" {
  source = "github.com/pagopa/dx//infra/modules/azure_function_app?ref=15236aabcaf855b5b00709bcbb9b0ec177ba71b9"

  environment = {
    prefix          = var.prefix
    env_short       = var.env_short
    location        = local.itn_location
    domain          = "auth"
    app_name        = "lv"
    instance_number = "01"
  }

  resource_group_name = azurerm_resource_group.fast_login_rg_itn.name
  health_check_path   = "/info"
  node_version        = 18
  tier                = "xl"

  subnet_cidr                          = var.cidr_subnet_fnfastlogin_itn
  subnet_pep_id                        = data.azurerm_subnet.itn_pep.id
  private_dns_zone_resource_group_name = data.azurerm_virtual_network.vnet_common.resource_group_name

  virtual_network = {
    name                = data.azurerm_virtual_network.common_vnet_italy_north.name
    resource_group_name = data.azurerm_virtual_network.common_vnet_italy_north.resource_group_name
  }

  app_settings = merge(
    local.function_fast_login.app_settings,
    { "REDIS_URL"  = data.azurerm_redis_cache.redis_common_itn.hostname,
      "REDIS_PORT" = data.azurerm_redis_cache.redis_common_itn.ssl_port,
    "REDIS_PASSWORD" = data.azurerm_redis_cache.redis_common_itn.primary_access_key },
  )
  slot_app_settings = merge(
    local.function_fast_login.app_settings,
    { "REDIS_URL"  = data.azurerm_redis_cache.redis_common_itn.hostname,
      "REDIS_PORT" = data.azurerm_redis_cache.redis_common_itn.ssl_port,
    "REDIS_PASSWORD" = data.azurerm_redis_cache.redis_common_itn.primary_access_key },
  )

  tags = var.tags
}

module "function_fast_login" {
  count  = var.fastlogin_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v8.22.0"

  resource_group_name          = azurerm_resource_group.fast_login_rg[0].name
  name                         = format("%s-fast-login-fn", local.common_project)
  location                     = var.location
  domain                       = "IO-COMMONS"
  health_check_path            = "/info"
  health_check_maxpingfailures = "2"

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_fastlogin_kind
    sku_size                     = var.function_fastlogin_sku_size
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = false
  }

  app_settings = merge(
    local.function_fast_login.app_settings,
    { "FUNCTIONS_WORKER_PROCESS_COUNT" = 4,
      "REDIS_URL"                      = data.azurerm_redis_cache.redis_common.hostname,
      "REDIS_PORT"                     = data.azurerm_redis_cache.redis_common.ssl_port,
    "REDIS_PASSWORD" = data.azurerm_redis_cache.redis_common.primary_access_key },
  )

  sticky_app_setting_names = []

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

  subnet_id = module.fast_login_snet[0].id

  allowed_subnets = [
    module.fast_login_snet[0].id,
    data.azurerm_subnet.apim_v2_snet.id,
    data.azurerm_subnet.app_backend_l1_snet.id,
    data.azurerm_subnet.app_backend_l2_snet.id,
    data.azurerm_subnet.ioweb_profile_snet.id,
    module.session_manager_snet.id,
  ]

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}

module "function_fast_login_staging_slot" {
  count  = var.fastlogin_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v8.22.0"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.fast_login_rg[0].name
  function_app_id     = module.function_fast_login[0].id
  app_service_plan_id = module.function_fast_login[0].app_service_plan_id
  health_check_path   = "/info"

  storage_account_name               = module.function_fast_login[0].storage_account.name
  storage_account_access_key         = module.function_fast_login[0].storage_account.primary_access_key
  internal_storage_connection_string = module.function_fast_login[0].storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_fast_login.app_settings,
    { "FUNCTIONS_WORKER_PROCESS_COUNT" = 4,
      "REDIS_URL"                      = data.azurerm_redis_cache.redis_common.hostname,
      "REDIS_PORT"                     = data.azurerm_redis_cache.redis_common.ssl_port,
    "REDIS_PASSWORD" = data.azurerm_redis_cache.redis_common.primary_access_key }
  )

  subnet_id = module.fast_login_snet[0].id

  allowed_subnets = [
    module.fast_login_snet[0].id,
    data.azurerm_subnet.azdoa_snet[0].id,
    data.azurerm_subnet.apim_v2_snet.id,
    data.azurerm_subnet.app_backend_l1_snet.id,
    data.azurerm_subnet.app_backend_l2_snet.id
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_fast_login" {
  name                = "${replace(module.function_fast_login[0].name, "fn", "as")}-01"
  resource_group_name = azurerm_resource_group.fast_login_rg[0].name
  location            = var.location
  target_resource_id  = module.function_fast_login[0].app_service_plan_id

  profile {
    name = "evening"

    capacity {
      default = 10
      minimum = 4
      maximum = 20
    }

    recurrence {
      timezone = "W. Europe Standard Time"
      hours    = [19]
      minutes  = [30]
      days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ]
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_fast_login[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 2500
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_fast_login[0].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 35
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "4"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_fast_login[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 200
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_fast_login[0].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 15
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  profile {
    name = "night"

    capacity {
      default = 10
      minimum = 2
      maximum = 15
    }

    recurrence {
      timezone = "W. Europe Standard Time"
      hours    = [23]
      minutes  = [0]
      days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ]
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_fast_login[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 3200
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_fast_login[0].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 45
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "3"
        cooldown  = "PT2M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_fast_login[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 500
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_fast_login[0].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 20
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT2M"
      }
    }
  }

  profile {
    name = "{\"name\":\"default\",\"for\":\"evening\"}"

    recurrence {
      timezone = "W. Europe Standard Time"
      hours    = [22]
      minutes  = [59]
      days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ]
    }

    capacity {
      default = 10
      minimum = 3
      maximum = 30
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_fast_login[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 3000
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_fast_login[0].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 35
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "4"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_fast_login[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 300
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_fast_login[0].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 15
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT2M"
      }
    }
  }

  profile {
    name = "{\"name\":\"default\",\"for\":\"night\"}"

    recurrence {
      timezone = "W. Europe Standard Time"
      hours    = [5]
      minutes  = [0]
      days = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ]
    }

    capacity {
      default = 10
      minimum = 3
      maximum = 30
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_fast_login[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 3000
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_fast_login[0].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 35
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "4"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_fast_login[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 300
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_fast_login[0].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 15
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT2M"
      }
    }
  }

  tags = var.tags
}
