resource "azurerm_monitor_metric_alert" "this" {
  for_each = local.monitor_metric_alert_criteria

  name                = "${azurerm_application_gateway.this.name}-${upper(each.key)}"
  description         = each.value.description
  resource_group_name = var.resource_group_common
  scopes              = [azurerm_application_gateway.this.id]
  frequency           = each.value.frequency
  window_size         = each.value.window_size
  enabled             = true
  severity            = each.value.severity
  auto_mitigate       = each.value.auto_mitigate

  dynamic "action" {
    for_each = local.action
    content {
      action_group_id    = action.value["action_group_id"]
      webhook_properties = action.value["webhook_properties"]
    }
  }

  dynamic "criteria" {
    for_each = each.value.criteria
    content {
      aggregation      = criteria.value.aggregation
      metric_namespace = local.metric_namespace
      metric_name      = criteria.value.metric_name
      operator         = criteria.value.operator
      threshold        = criteria.value.threshold

      dynamic "dimension" {
        for_each = criteria.value.dimension
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }

  dynamic "dynamic_criteria" {
    for_each = each.value.dynamic_criteria
    content {
      aggregation              = dynamic_criteria.value.aggregation
      metric_namespace         = local.metric_namespace
      metric_name              = dynamic_criteria.value.metric_name
      operator                 = dynamic_criteria.value.operator
      alert_sensitivity        = dynamic_criteria.value.alert_sensitivity
      evaluation_total_count   = dynamic_criteria.value.evaluation_total_count
      evaluation_failure_count = dynamic_criteria.value.evaluation_failure_count

      dynamic "dimension" {
        for_each = dynamic_criteria.value.dimension
        content {
          name     = dimension.value.name
          operator = dimension.value.operator
          values   = dimension.value.values
        }
      }
    }
  }
  tags = var.tags
}