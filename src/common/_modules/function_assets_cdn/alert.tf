resource "azurerm_monitor_metric_alert" "function_assets_health_check" {
  name                = "${module.function_assets_cdn_itn.function_app.function_app.name}-health-check-failed"
  resource_group_name = azurerm_resource_group.function_assets_cdn_itn_rg.name
  scopes              = [module.function_assets_cdn_itn.id]
  description         = "${module.function_assets_cdn_itn.function_app.function_app.name} health check failed"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 50
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.error_action_group.id
  }
}

resource "azurerm_monitor_metric_alert" "function_assets_http_server_errors" {
  name                = "${module.function_assets_cdn_itn.function_app.function_app.name}-http-server-errors"
  resource_group_name = azurerm_resource_group.function_assets_cdn_itn_rg.name
  scopes              = [module.function_assets_cdn_itn.id]
  description         = "${module.function_assets_cdn_itn.function_app.function_app.name} http server errors"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 50
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.error_action_group.id
  }
}

resource "azurerm_monitor_metric_alert" "function_assets_response_time" {
  name                = "${module.function_assets_cdn_itn.function_app.function_app.name}-response-time"
  resource_group_name = azurerm_resource_group.function_assets_cdn_itn_rg.name
  scopes              = [module.function_assets_cdn_itn.id]
  description         = "${module.function_assets_cdn_itn.function_app.function_app.name} response time is greater than 0.5s"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HttpResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0.5
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.error_action_group.id
  }
}