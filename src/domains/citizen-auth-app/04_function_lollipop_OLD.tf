
resource "azurerm_resource_group" "lollipop_rg" {
  count    = var.lollipop_enabled ? 1 : 0
  name     = format("%s-lollipop-rg", local.common_project)
  location = var.location

  tags = var.tags
}

# Subnet to host admin function
module "lollipop_snet" {
  count                                     = var.lollipop_enabled ? 1 : 0
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.22.0"
  name                                      = format("%s-lollipop-snet", local.common_project)
  address_prefixes                          = var.cidr_subnet_fnlollipop
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

module "function_lollipop" {
  count  = var.lollipop_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v8.22.0"

  resource_group_name = azurerm_resource_group.lollipop_rg[0].name
  name                = format("%s-lollipop-fn", local.common_project)
  location            = var.location
  domain              = "IO-COMMONS"
  health_check_path   = "/info"

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_lollipop_kind
    sku_size                     = var.function_lollipop_sku_size
    maximum_elastic_worker_count = 0
    // worker count is managed by autoscaling settings
    worker_count           = null
    zone_balancing_enabled = false
  }

  app_settings = merge(
    local.function_lollipop.app_settings,
    {
      "LOLLIPOP_ASSERTION_REVOKE_QUEUE"          = "pubkeys-revoke",
      "AzureWebJobs.HandlePubKeyRevoke.Disabled" = "0"
    },
  )

  sticky_app_setting_names = ["AzureWebJobs.HandlePubKeyRevoke.Disabled"]

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

  subnet_id = module.lollipop_snet[0].id

  allowed_subnets = [
    module.lollipop_snet[0].id,
    data.azurerm_subnet.apim_v2_snet.id,
    data.azurerm_subnet.app_backend_l1_snet.id,
    data.azurerm_subnet.app_backend_l2_snet.id,
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

module "function_lollipop_staging_slot" {
  count  = var.lollipop_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v8.22.0"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.lollipop_rg[0].name
  function_app_id     = module.function_lollipop[0].id
  app_service_plan_id = module.function_lollipop[0].app_service_plan_id
  health_check_path   = "/info"

  storage_account_name               = module.function_lollipop[0].storage_account.name
  storage_account_access_key         = module.function_lollipop[0].storage_account.primary_access_key
  internal_storage_connection_string = module.function_lollipop[0].storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_lollipop.app_settings,
    {
      "LOLLIPOP_ASSERTION_REVOKE_QUEUE"          = "pubkeys-revoke",
      "AzureWebJobs.HandlePubKeyRevoke.Disabled" = "1"
    },
  )

  subnet_id = module.lollipop_snet[0].id

  allowed_subnets = [
    module.lollipop_snet[0].id,
    data.azurerm_subnet.azdoa_snet[0].id,
    data.azurerm_subnet.apim_v2_snet.id,
    data.azurerm_subnet.app_backend_l1_snet.id,
    data.azurerm_subnet.app_backend_l2_snet.id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_lollipop" {
  count               = var.lollipop_enabled ? 1 : 0
  name                = format("%s-autoscale", module.function_lollipop[0].name)
  resource_group_name = azurerm_resource_group.lollipop_rg[0].name
  location            = var.location
  target_resource_id  = module.function_lollipop[0].app_service_plan_id

  dynamic "profile" {
    for_each = local.function_lollipop.autoscale_profiles
    iterator = profile_info

    content {
      name = profile_info.value.name


      dynamic "recurrence" {
        for_each = profile_info.value.recurrence != null ? [profile_info.value.recurrence] : []
        iterator = recurrence_info

        content {
          timezone = "W. Europe Standard Time"
          hours    = [recurrence_info.value.hours]
          minutes  = [recurrence_info.value.minutes]
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
      }

      capacity {
        default = profile_info.value.capacity.default
        minimum = profile_info.value.capacity.minimum
        maximum = profile_info.value.capacity.maximum
      }


      # Increase

      rule {
        metric_trigger {
          metric_name              = "Requests"
          metric_resource_id       = module.function_lollipop[0].id
          metric_namespace         = "microsoft.web/sites"
          time_grain               = "PT1M"
          statistic                = "Average"
          time_window              = "PT1M"
          time_aggregation         = "Average"
          operator                 = "GreaterThan"
          threshold                = 3000
          divide_by_instance_count = false
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
          metric_resource_id       = module.function_lollipop[0].app_service_plan_id
          metric_namespace         = "microsoft.web/serverfarms"
          time_grain               = "PT1M"
          statistic                = "Average"
          time_window              = "PT1M"
          time_aggregation         = "Average"
          operator                 = "GreaterThan"
          threshold                = 45
          divide_by_instance_count = false
        }

        scale_action {
          direction = "Increase"
          type      = "ChangeCount"
          value     = "2"
          cooldown  = "PT1M"
        }
      }

      # Decrease

      rule {
        metric_trigger {
          metric_name              = "Requests"
          metric_resource_id       = module.function_lollipop[0].id
          metric_namespace         = "microsoft.web/sites"
          time_grain               = "PT1M"
          statistic                = "Average"
          time_window              = "PT15M"
          time_aggregation         = "Average"
          operator                 = "LessThan"
          threshold                = 2000
          divide_by_instance_count = false
        }

        scale_action {
          direction = "Decrease"
          type      = "ChangeCount"
          value     = "1"
          cooldown  = "PT10M"
        }
      }

      rule {
        metric_trigger {
          metric_name              = "CpuPercentage"
          metric_resource_id       = module.function_lollipop[0].app_service_plan_id
          metric_namespace         = "microsoft.web/serverfarms"
          time_grain               = "PT1M"
          statistic                = "Average"
          time_window              = "PT15M"
          time_aggregation         = "Average"
          operator                 = "LessThan"
          threshold                = 30
          divide_by_instance_count = false
        }

        scale_action {
          direction = "Decrease"
          type      = "ChangeCount"
          value     = "1"
          cooldown  = "PT10M"
        }
      }
    }
  }
}

# ---------------------------------
# Alerts
# ---------------------------------

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert_function_lollipop_HandlePubKeyRevoke_failure" {
  count = var.lollipop_enabled ? 1 : 0

  name                = "[${upper(var.domain)}|${module.function_lollipop[0].name}] The revocation of one or more PubKeys has failed"
  resource_group_name = azurerm_resource_group.lollipop_rg[0].name
  location            = var.location

  // check once per day
  evaluation_frequency = "P1D"
  window_duration      = "P1D"
  scopes               = [data.azurerm_application_insights.application_insights.id]
  severity             = 1
  criteria {
    query                   = <<-QUERY
exceptions
| where cloud_RoleName == "${module.function_lollipop[0].name}"
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
