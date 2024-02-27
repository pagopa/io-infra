resource "azurerm_monitor_metric_alert" "function_cgn_health_check" {
  name                = "${module.function_cgn.name}-health-check-failed"
  resource_group_name = azurerm_resource_group.cgn_be_rg.name
  scopes              = [module.function_cgn.id]
  description         = "${module.function_cgn.name} health check failed"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 50
  }

  action {
    action_group_id = azurerm_monitor_action_group.error_action_group.id
  }
}

resource "azurerm_monitor_metric_alert" "function_cgn_merchant_health_check" {
  name                = "${module.function_cgn_merchant.name}-health-check-failed"
  resource_group_name = azurerm_resource_group.cgn_be_rg.name
  scopes              = [module.function_cgn_merchant.id]
  description         = "${module.function_cgn_merchant.name} health check failed"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false
  enabled             = false # todo enable after deploy

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 50
  }

  action {
    action_group_id = azurerm_monitor_action_group.error_action_group.id
  }
}
