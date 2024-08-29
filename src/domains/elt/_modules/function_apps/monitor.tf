data "azurerm_monitor_action_group" "quarantine_error_action_group" {
  resource_group_name = local.resource_group_name_common
  name                = "${replace(var.project, "-", "")}quarantineerror"
}

resource "azurerm_monitor_diagnostic_setting" "queue_diagnostic_setting" {
  name                       = "${var.project}-fnelt-internal-st-queue-ds-01"
  target_resource_id         = "${data.azurerm_storage_account.function_elt_internal_storage.id}/queueServices/default"
  log_analytics_workspace_id = data.azurerm_application_insights.application_insights.workspace_id

  enabled_log {
    category = "StorageWrite"
  }

  metric {
    category = "Capacity"
    enabled  = false
  }
  metric {
    category = "Transaction"
    enabled  = false
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert_v2" "service_preferences_failure_alert_rule" {
  enabled             = true
  name                = "[CITIZEN-AUTH | iopfneltsdt] Failures on pdnd-io-cosmosdb-service-preferences-failure-poison"
  resource_group_name = var.resource_group_name
  location            = var.location

  scopes                  = [data.azurerm_storage_account.function_elt_internal_storage.id]
  description             = "Permanent failures processing Service Preferences export to PDND. REQUIRED MANUAL ACTION"
  severity                = 1
  auto_mitigation_enabled = false

  window_duration      = "PT15M" # Select the interval that's used to group the data points by using the aggregation type function. Choose an Aggregation granularity (period) that's greater than the Frequency of evaluation to reduce the likelihood of missing the first evaluation period of an added time series.
  evaluation_frequency = "PT15M" # Select how often the alert rule is to be run. Select a frequency that's smaller than the aggregation granularity to generate a sliding window for the evaluation.

  criteria {
    query                   = <<-QUERY
      StorageQueueLogs
        | where OperationName contains "PutMessage"
        | where Uri contains "${local.service_preferences_failure_queue_name}-poison"
      QUERY
    operator                = "GreaterThan"
    threshold               = 0
    time_aggregation_method = "Count"
  }

  action {
    action_groups = [
      data.azurerm_monitor_action_group.quarantine_error_action_group.id,
    ]
  }

  tags = var.tags
}