
resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert_failed_delete_procedure" {
  enabled             = true
  name                = "[IO-AUTH | ${module.function_admin_dx.function_app.function_app.name}] Found one or more failed DELETE procedures"
  resource_group_name = azurerm_resource_group.function_admin_itn_rg.name
  scopes              = [data.azurerm_application_insights.application_insights.id]
  description         = <<EOT
    Found one or more failed DELETE procedures.
    Check ${local.function_admin.app_settings_common.FAILED_USER_DATA_PROCESSING_TABLE} table in
    ${data.azurerm_storage_account.storage_api.name} storage account for more details
    EOT

  severity                = 1
  auto_mitigation_enabled = false
  location                = var.location_itn

  // check once every day(evaluation_frequency)
  // on the last 24 hours of data(window_duration)
  evaluation_frequency = "P1D"
  window_duration      = "P1D"

  criteria {
    query                   = <<-QUERY
exceptions
| where cloud_RoleName == "${module.function_admin_dx.function_app.function_app.name}"
| where customDimensions.name startswith "user.data.delete"
    QUERY
    operator                = "GreaterThanOrEqual"
    time_aggregation_method = "Count"
    threshold               = 1
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  # Action groups for alerts
  action {
    action_groups = [data.azurerm_monitor_action_group.io_auth_error_action_group.id]
  }

  tags = var.tags
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "alert_failed_download_procedure" {
  enabled             = true
  name                = "[IO-AUTH | ${module.function_admin_dx.function_app.function_app.name}] Found one or more failed DOWNLOAD procedures"
  resource_group_name = azurerm_resource_group.function_admin_itn_rg.name
  scopes              = [data.azurerm_application_insights.application_insights.id]
  description         = <<EOT
    Found one or more failed DOWNLOAD procedures.
    Check ${local.function_admin.app_settings_common.FAILED_USER_DATA_PROCESSING_TABLE} table in
    ${data.azurerm_storage_account.storage_api.name} storage account for more details
    EOT

  severity                = 1
  auto_mitigation_enabled = false
  location                = var.location_itn

  // check once every day(evaluation_frequency)
  // on the last 24 hours of data(window_duration)
  evaluation_frequency = "P1D"
  window_duration      = "P1D"

  criteria {
    query                   = <<-QUERY
exceptions
| where cloud_RoleName == "${module.function_admin_dx.function_app.function_app.name}"
| where customDimensions.name startswith "user.data.download"
    QUERY
    operator                = "GreaterThanOrEqual"
    time_aggregation_method = "Count"
    threshold               = 1
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  # Action groups for alerts
  action {
    action_groups = [data.azurerm_monitor_action_group.io_auth_error_action_group.id]
  }

  tags = var.tags
}
