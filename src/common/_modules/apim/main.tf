module "apim_v2" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management?ref=v8.85.0"

  subnet_id                 = azurerm_subnet.apim.id
  location                  = var.location
  name                      = try(local.nonstandard[var.location_short].apim_name, "${var.project}-apim-01")
  resource_group_name       = var.resource_group_internal
  publisher_name            = "IO"
  publisher_email           = data.azurerm_key_vault_secret.apim_publisher_email.value
  notification_sender_email = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name                  = "Premium_2"
  virtual_network_type      = "Internal"
  zones                     = ["1", "2"]
  min_api_version           = var.min_api_version

  redis_cache_id       = null
  public_ip_address_id = azurerm_public_ip.apim.id

  hostname_configuration = {
    proxy = [
      {
        # io-p-apim-api.azure-api.net
        default_ssl_binding = false
        host_name           = "io-p-itn-apim-01.azure-api.net"
        key_vault_id        = null
      },
      {
        # api-internal.io.italia.it
        default_ssl_binding = true
        host_name           = local.apim_hostname_api_internal
        key_vault_id = replace(
          data.azurerm_key_vault_certificate.api_internal_io_italia_it.secret_id,
          "/${data.azurerm_key_vault_certificate.api_internal_io_italia_it.version}",
          ""
        )
      },
      {
        # api-app.internal.io.pagopa.it
        default_ssl_binding = false
        host_name           = local.apim_hostname_api_app_internal
        key_vault_id = replace(
          data.azurerm_key_vault_certificate.api_app_internal_io_pagopa_it.secret_id,
          "/${data.azurerm_key_vault_certificate.api_app_internal_io_pagopa_it.version}",
          ""
        )
      },
    ]
    developer_portal = null
    management       = null
    portal           = null
  }

  management_logger_applicaiton_insight_enabled = true
  application_insights = {
    enabled             = true
    instrumentation_key = var.ai_instrumentation_key
  }

  autoscale = {
    enabled                       = true
    default_instances             = 3
    minimum_instances             = 2
    maximum_instances             = 6
    scale_out_capacity_percentage = 50
    scale_out_time_window         = "PT3M"
    scale_out_value               = "1"
    scale_out_cooldown            = "PT5M"
    scale_in_capacity_percentage  = 20
    scale_in_time_window          = "PT5M"
    scale_in_value                = "1"
    scale_in_cooldown             = "PT5M"
  }

  action = [
    {
      action_group_id    = var.action_group_id
      webhook_properties = null
    }
  ]

  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftapimanagementservice
  metric_alerts = {
    capacity = {
      description   = "Apim used capacity is too high. Runbook: https://pagopa.atlassian.net/wiki/spaces/IC/pages/791642113/APIM+Capacity"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = [{
        metric_namespace       = "Microsoft.ApiManagement/service"
        metric_name            = "Capacity"
        aggregation            = "Average"
        operator               = "GreaterThan"
        threshold              = 60
        skip_metric_validation = false
        dimension              = []
      }]
      dynamic_criteria = []
    }

    duration = {
      description   = "Apim abnormal response time"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Duration"
        aggregation              = "Average"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension                = []
      }]
    }

    requests_failed = {
      description   = "Apim abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Requests"
        aggregation              = "Total"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension = [{
          name     = "BackendResponseCode"
          operator = "Include"
          values   = ["5xx"]
        }]
      }]
    }
  }

  tags = var.tags
}
