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

      FUNCTIONS_WORKER_PROCESS_COUNT = 8

      # Redis
      REDIS_URL      = data.azurerm_redis_cache.redis_common_itn.hostname
      REDIS_PORT     = data.azurerm_redis_cache.redis_common_itn.ssl_port
      REDIS_PASSWORD = data.azurerm_redis_cache.redis_common_itn.primary_access_key

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


resource "azurerm_resource_group" "fast_login_rg_itn" {
  name     = format("%s-fast-login-rg-01", local.common_project_itn)
  location = local.itn_location

  tags = var.tags
}

## Create resources for fast-login on ITN Region

module "fast_login_snet_itn" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.22.0"
  name                                      = format("%s-fast-login-snet-01", local.project_itn)
  address_prefixes                          = var.cidr_subnet_fnfastlogin_itn
  resource_group_name                       = data.azurerm_virtual_network.common_vnet_italy_north.resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.common_vnet_italy_north.name
  private_endpoint_network_policies_enabled = true

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
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v8.44.0"

  resource_group_name          = azurerm_resource_group.fast_login_rg_itn.name
  name                         = format("%s-auth-lv-fn-01", local.common_project_itn)
  location                     = local.itn_location
  domain                       = "auth"
  health_check_path            = "/info"
  health_check_maxpingfailures = "2"

  enable_function_app_public_network_access = false

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_fastlogin_kind
    sku_size                     = var.function_fastlogin_sku_size
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = true
  }

  app_settings = local.function_fast_login.app_settings

  sticky_app_setting_names = []

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.itn_pep.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 0,
  }

  subnet_id = module.fast_login_snet_itn.id

  allowed_subnets = [
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

module "function_fast_login_staging_slot_itn" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v8.44.0"

  name                = "staging"
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.fast_login_rg_itn.name
  function_app_id     = module.function_fast_login_itn.id
  app_service_plan_id = module.function_fast_login_itn.app_service_plan_id
  health_check_path   = "/info"

  storage_account_name               = module.function_fast_login_itn.storage_account.name
  storage_account_access_key         = module.function_fast_login_itn.storage_account.primary_access_key
  internal_storage_connection_string = module.function_fast_login_itn.storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = local.function_fast_login.app_settings

  subnet_id = module.fast_login_snet_itn.id

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  tags = var.tags
}

module "function_fast_login_itn_autoscale" {
  source = "github.com/pagopa/dx//infra/modules/azure_app_service_plan_autoscaler?ref=main"

  resource_group_name = azurerm_resource_group.fast_login_rg_itn.name
  target_service = {
    function_app_name = module.function_fast_login_itn.name
  }

  scheduler = {
    high_load = {
      name    = "evening"
      minimum = 4
      default = 10
      start = {
        hour    = 19
        minutes = 30
      }
      end = {
        hour    = 22
        minutes = 59
      }
    },
    spot_load = {
      name       = "${module.common_values.scaling_gate.name}"
      minimum    = 6
      default    = 20
      start_date = module.common_values.scaling_gate.start
      end_date   = module.common_values.scaling_gate.end
    },
    normal_load = {
      minimum = 3
      default = 10
    },
    maximum = 30
  }

  scale_metrics = {
    requests = {
      statistic_increase        = "Max"
      time_window_increase      = 1
      time_aggregation          = "Maximum"
      upper_threshold           = 2500
      increase_by               = 2
      cooldown_increase         = 1
      statistic_decrease        = "Average"
      time_window_decrease      = 5
      time_aggregation_decrease = "Average"
      lower_threshold           = 200
      decrease_by               = 1
      cooldown_decrease         = 1
    }
    cpu = {
      upper_threshold           = 35
      lower_threshold           = 15
      increase_by               = 3
      decrease_by               = 1
      cooldown_increase         = 1
      cooldown_decrease         = 20
      statistic_increase        = "Max"
      statistic_decrease        = "Average"
      time_aggregation_increase = "Maximum"
      time_aggregation_decrease = "Average"
      time_window_increase      = 1
      time_window_decrease      = 5
    }
    memory = null
  }

  tags = var.tags
}
