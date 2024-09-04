resource "azurerm_application_insights_standard_web_test" "web_tests" {
  for_each = { for v in var.test_urls : v.name => v if v != null }

  name                    = format("%s-test-%s", each.value.name, azurerm_application_insights.appi.name)
  resource_group_name     = azurerm_application_insights.appi.resource_group_name
  location                = azurerm_application_insights.appi.location
  application_insights_id = azurerm_application_insights.appi.id
  geo_locations           = ["emea-nl-ams-azr"] # https://learn.microsoft.com/en-us/previous-versions/azure/azure-monitor/app/monitor-web-app-availability#location-population-tags
  frequency               = each.value.frequency
  enabled                 = each.value.enabled
  retry_enabled           = true

  request {
    url                              = format("https://%s%s", each.value.host, each.value.path)
    follow_redirects_enabled         = false
    parse_dependent_requests_enabled = false
  }

  validation_rules {
    expected_status_code        = each.value.http_status
    ssl_cert_remaining_lifetime = each.value.ssl_enabled ? each.value.ssl_cert_remaining_lifetime_check : null
    ssl_check_enabled           = each.value.ssl_enabled
  }
}

resource "azurerm_monitor_metric_alert" "metric_alerts" {
  for_each = { for v in var.test_urls : v.name => v if v != null }

  name                = format("%s-test-%s", each.value.name, azurerm_application_insights.appi.name)
  resource_group_name = azurerm_application_insights.appi.resource_group_name
  severity            = 1
  scopes = [
    azurerm_application_insights.appi.id,
    azurerm_application_insights_standard_web_test.web_tests[each.value.name].id
  ]
  description   = "Web availability check alert triggered when it fails. Runbook: https://pagopa.atlassian.net/wiki/spaces/IC/pages/762347521/Web+Availability+Test+-+TLS+Probe+Check"
  auto_mitigate = false

  application_insights_web_test_location_availability_criteria {
    web_test_id           = azurerm_application_insights_standard_web_test.web_tests[each.value.name].id
    component_id          = azurerm_application_insights.appi.id
    failed_location_count = 1
  }

  action {
    action_group_id = azurerm_monitor_action_group.error.id
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "mailup" {
  name                = "[SEND.MAILUP.COM] Many Failures"
  resource_group_name = azurerm_application_insights.appi.resource_group_name
  location            = azurerm_application_insights.appi.location

  display_name = "[SEND.MAILUP.COM] Many Failures"

  criteria {
    query = <<-QUERY
    let timeGrain=5m;
    let dataset=dependencies
        // additional filters can be applied here
        | where client_Type != "Browser"
        | where target contains "send.mailup.com"
        | where success == false;
    dataset
  QUERY

    operator                = "GreaterThan"
    threshold               = 10
    time_aggregation_method = "Count"

    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  window_duration      = "PT30M"
  evaluation_frequency = "PT5M"
  severity             = 1

  scopes = [
    azurerm_application_insights.appi.id,
  ]

  description             = "Check in Application Insight - Dependencies the mailup calls. Runbook: https://pagopa.atlassian.net/wiki/spaces/IC/pages/777650829/MailUp+Communication+Failures"
  enabled                 = true
  auto_mitigation_enabled = false

  action {
    action_groups = [
      azurerm_monitor_action_group.error.id,
    ]
  }

  tags = var.tags
}
