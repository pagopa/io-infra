##########################
# APP GATEWAY DATA SOURCE
##########################
data "azurerm_application_gateway" "app_gateway" {
  name                = format("%s-appgateway", local.product)
  resource_group_name = local.appgw_resource_group_name
}
##########################

data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = var.application_insights_name
  resource_group_name = var.monitor_resource_group_name
}

data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = var.monitor_resource_group_name
  name                = "${var.prefix}${var.env_short}error"
}

data "azurerm_monitor_action_group" "quarantine_error_action_group" {
  resource_group_name = var.monitor_resource_group_name
  name                = "${var.prefix}${var.env_short}quarantineerror"
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

resource "azurerm_monitor_scheduled_query_rules_alert_v2" "samlresponse_missing_detection_alert" {
  enabled                 = true
  name                    = "[${upper(var.domain)}] Missing required SAMLResponse in assertionConsumerService"
  resource_group_name     = data.azurerm_resource_group.monitor_rg.name
  scopes                  = [data.azurerm_application_gateway.app_gateway.id]
  description             = <<-EOT
    Detected multiple SAMLResponse missing during assertionConsumerService.
    IdP is unknown here but you can watch Mixpanel events to identify the IdP
    that is causing the alert to trigger
  EOT
  severity                = 1
  auto_mitigation_enabled = true
  location                = data.azurerm_resource_group.monitor_rg.location

  // check once every 5 minutes(evaluation_frequency)
  // on the last 10 minutes of data(window_duration)
  evaluation_frequency = "PT5M"
  window_duration      = "PT10M"

  criteria {
    query                   = <<-QUERY
AzureDiagnostics
| where originalHost_s in ("app-backend.io.italia.it", "api-app.io.pagopa.it")
| where requestUri_s == "/error.html"
| where httpMethod_s == "GET"
| where requestQuery_s contains "Missing%20SAMLResponse%20in%20ACS"
    QUERY
    operator                = "GreaterThanOrEqual"
    time_aggregation_method = "Count"
    threshold               = 5
    failing_periods {
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
    }
  }

  # Action groups for alerts
  action {
    action_groups = [data.azurerm_monitor_action_group.error_action_group.id]
  }

  tags = var.tags
}
