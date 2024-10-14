data "azurerm_key_vault_secret" "first_lollipop_consumer_subscription_key" {
  name         = "first-lollipop-consumer-pagopa-subscription-key-v2"
  key_vault_id = data.azurerm_key_vault.kv.id
}

locals {
  function_lollipop = {
    app_settings = {
      FUNCTIONS_WORKER_PROCESS_COUNT = 8
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      COSMOSDB_NAME                = "citizen-auth"
      COSMOSDB_URI                 = data.azurerm_cosmosdb_account.cosmos_citizen_auth.endpoint
      COSMOSDB_KEY                 = data.azurerm_cosmosdb_account.cosmos_citizen_auth.primary_key
      COSMOS_API_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_citizen_auth.endpoint, data.azurerm_cosmosdb_account.cosmos_citizen_auth.primary_key)

      #TODO: move to new storage on itn
      LOLLIPOP_ASSERTION_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.lollipop_assertion_storage.primary_connection_string
      LOLLIPOP_ASSERTION_REVOKE_QUEUE              = "pubkeys-revoke-v2"

      // ------------
      // JWT Config
      // ------------
      ISSUER = local.lollipop_jwt_host

      PRIMARY_PRIVATE_KEY = trimspace(data.azurerm_key_vault_certificate_data.lollipop_certificate_v1.key)
      PRIMARY_PUBLIC_KEY  = trimspace(data.azurerm_key_vault_certificate_data.lollipop_certificate_v1.pem)

      // Use it during rotation period. See https://pagopa.atlassian.net/wiki/spaces/IC/pages/645136398/LolliPoP+Procedura+di+rotazione+dei+certificati
      //SECONDARY_PUBLIC_KEY =


      // -------------------------
      // First LolliPoP Consumer
      // -------------------------
      FIRST_LC_ASSERTION_CLIENT_BASE_URL         = "https://api.io.pagopa.it"
      FIRST_LC_ASSERTION_CLIENT_SUBSCRIPTION_KEY = data.azurerm_key_vault_secret.first_lollipop_consumer_subscription_key.value
    }
  }
}

resource "azurerm_resource_group" "lollipop_rg_itn" {
  name     = format("%s-lollipop-rg-01", local.common_project_itn)
  location = local.itn_location

  tags = var.tags
}

# Subnet to host admin function

resource "azurerm_subnet" "lollipop_snet_itn" {
  name                 = format("%s-lollipop-snet-01", local.common_project_itn)
  resource_group_name  = data.azurerm_virtual_network.common_vnet_italy_north.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.common_vnet_italy_north.name
  address_prefixes     = var.cidr_subnet_fnlollipop_itn

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
    "Microsoft.Storage",
  ]

  delegation {
    name = "default"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies_enabled     = true
}

module "function_lollipop_itn" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v8.28.2"

  resource_group_name          = azurerm_resource_group.lollipop_rg_itn.name
  name                         = format("%s-lollipop-fn-01", local.common_project_itn)
  location                     = local.itn_location
  domain                       = "IO-COMMONS"
  health_check_path            = "/info"
  health_check_maxpingfailures = "2"

  enable_function_app_public_network_access = false

  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "ZRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = false
    public_network_access_enabled     = false
    use_legacy_defender_version       = true
  }

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_lollipop_kind
    sku_size                     = var.function_lollipop_sku_size
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = true
  }

  app_settings = merge(
    local.function_lollipop.app_settings,
    { "AzureWebJobs.HandlePubKeyRevoke.Disabled" = "0" },
  )

  sticky_app_setting_names = ["AzureWebJobs.HandlePubKeyRevoke.Disabled"]

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

  subnet_id = azurerm_subnet.lollipop_snet_itn.id

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}

module "function_lollipop_staging_slot_itn" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app_slot?ref=v8.28.2"

  name                = "staging"
  location            = local.itn_location
  resource_group_name = azurerm_resource_group.lollipop_rg_itn.name
  function_app_id     = module.function_lollipop_itn.id
  app_service_plan_id = module.function_lollipop_itn.app_service_plan_id
  health_check_path   = "/info"

  storage_account_name               = module.function_lollipop_itn.storage_account.name
  storage_account_access_key         = module.function_lollipop_itn.storage_account.primary_access_key
  internal_storage_connection_string = module.function_lollipop_itn.storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_lollipop.app_settings,
    { "AzureWebJobs.HandlePubKeyRevoke.Disabled" = "1" },
  )

  subnet_id = azurerm_subnet.lollipop_snet_itn.id

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_lollipop_itn" {
  name                = replace(module.function_lollipop_itn.name, "-fn-", "-as-")
  resource_group_name = azurerm_resource_group.lollipop_rg_itn.name
  location            = local.itn_location
  target_resource_id  = module.function_lollipop_itn.app_service_plan_id

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
        metric_resource_id       = module.function_lollipop_itn.id
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
        metric_resource_id       = module.function_lollipop_itn.app_service_plan_id
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
        metric_resource_id       = module.function_lollipop_itn.id
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
        metric_resource_id       = module.function_lollipop_itn.app_service_plan_id
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
        metric_resource_id       = module.function_lollipop_itn.id
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
        metric_resource_id       = module.function_lollipop_itn.app_service_plan_id
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
        metric_resource_id       = module.function_lollipop_itn.id
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
        metric_resource_id       = module.function_lollipop_itn.app_service_plan_id
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
    name = "wallet_gate0"

    fixed_date {
      timezone = "W. Europe Standard Time"
      start    = "2024-10-15T08:00:00.000Z"
      end      = "2024-10-15T23:30:00.000Z"
    }

    capacity {
      default = 20
      minimum = 15
      maximum = 30
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_lollipop_itn.id
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
        metric_resource_id       = module.function_lollipop_itn.app_service_plan_id
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
        metric_resource_id       = module.function_lollipop_itn.id
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
        metric_resource_id       = module.function_lollipop_itn.app_service_plan_id
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

# ---------------------------------
# Alerts
# ---------------------------------

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert_function_lollipop_itn_HandlePubKeyRevoke_failure" {

  name                = "[${upper(var.domain)}|${module.function_lollipop_itn.name}] The revocation of one or more PubKeys has failed"
  resource_group_name = azurerm_resource_group.lollipop_rg_itn.name
  location            = var.location

  // check once per day
  evaluation_frequency = "P1D"
  window_duration      = "P1D"
  scopes               = [data.azurerm_application_insights.application_insights.id]
  severity             = 1
  criteria {
    query                   = <<-QUERY
exceptions
| where cloud_RoleName == "${module.function_lollipop_itn.name}"
| where outerMessage startswith "HandlePubKeyRevoke|"
| extend
  event_name = tostring(customDimensions.name),
  event_maxRetryCount = toint(customDimensions.maxRetryCount),
  event_retryCount = toint(customDimensions.retryCount),
  event_assertionRef = tostring(customDimensions.assertionRef),
  event_detail = tostring(customDimensions.detail),
  event_fatal = tostring(customDimensions.fatal),
  event_isSuccess = tostring(customDimensions.isSuccess),
  event_modelId = tostring(customDimensions.modelId)
| where event_name == "lollipop.pubKeys.revoke.failure" and event_retryCount == event_maxRetryCount-1
      QUERY
    time_aggregation_method = "Count"
    threshold               = 1
    operator                = "GreaterThanOrEqual"

    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  auto_mitigation_enabled = false
  description             = "One or more PubKey has not been revoked. Please, check the poison-queue and re-schedule the operation."
  enabled                 = true
  action {
    action_groups = [data.azurerm_monitor_action_group.error_action_group.id]
  }

  tags = var.tags
}
