resource "azurerm_application_insights_standard_web_test" "web_tests" {
  name                    = format("%s-test-%s", module.appservice_app_backend.default_site_hostname, var.application_insights.name)
  resource_group_name     = var.resource_group_common
  location                = var.application_insights.location
  application_insights_id = var.application_insights.id
  geo_locations           = ["emea-nl-ams-azr"] # https://learn.microsoft.com/en-us/previous-versions/azure/azure-monitor/app/monitor-web-app-availability#location-population-tags
  frequency               = 300
  enabled                 = true
  retry_enabled           = true

  request {
    url                              = "https://${module.appservice_app_backend.default_site_hostname}${local.webtest.path}"
    follow_redirects_enabled         = false
    parse_dependent_requests_enabled = false
  }

  validation_rules {
    expected_status_code        = local.webtest.http_status
    ssl_cert_remaining_lifetime = 7
    ssl_check_enabled           = true
  }
}

resource "azurerm_monitor_metric_alert" "metric_alerts" {
  name                = format("%s-test-%s", module.appservice_app_backend.default_site_hostname, var.application_insights.name)
  resource_group_name = var.resource_group_common
  severity            = 1
  scopes = [
    var.application_insights.id,
    azurerm_application_insights_standard_web_test.web_tests.id
  ]
  description   = "Web availability check alert triggered when it fails."
  auto_mitigate = false

  application_insights_web_test_location_availability_criteria {
    web_test_id           = azurerm_application_insights_standard_web_test.web_tests.id
    component_id          = var.application_insights.id
    failed_location_count = 1
  }

  action {
    action_group_id = var.error_action_group_id
  }
}

resource "azurerm_monitor_metric_alert" "too_many_http_5xx" {
  enabled = false

  name                = "[IO-COMMONS | ${module.appservice_app_backend.name}] Too many 5xx"
  resource_group_name = var.resource_group_linux
  scopes              = [module.appservice_app_backend.id]
  # TODO: add Runbook for checking errors
  description   = "Whenever the total http server errors exceeds a dynamic threashold. Runbook: ${"https://pagopa.atlassian.net"}/wiki/spaces/IC/pages/585072814/Appbackendlx+-+Too+many+errors"
  severity      = 0
  window_size   = "PT5M"
  frequency     = "PT5M"
  auto_mitigate = false

  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftwebsites
  dynamic_criteria {
    metric_namespace         = "Microsoft.Web/sites"
    metric_name              = "Http5xx"
    aggregation              = "Total"
    operator                 = "GreaterThan"
    alert_sensitivity        = "Low"
    evaluation_total_count   = 4
    evaluation_failure_count = 4
    skip_metric_validation   = false

  }

  action {
    action_group_id    = var.error_action_group_id
    webhook_properties = null
  }

  tags = var.tags
}
