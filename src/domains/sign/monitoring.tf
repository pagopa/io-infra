data "azurerm_application_insights" "application_insights" {
  name                = "io-p-ai-common"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_key_vault_secret" "monitor_fci_tech_email" {
  name         = "monitor-fci-tech-email"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "monitor_fci_tech_slack_email" {
  name         = "monitor-fci-tech-slack"
  key_vault_id = module.key_vault.id
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = "io-p-rg-common"
  name                = "SlackPagoPA"
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = "io-p-rg-common"
  name                = "EmailPagoPA"
}

resource "azurerm_monitor_action_group" "email_fci_tech" {
  name                = "EmailFirmaConIoTech"
  resource_group_name = azurerm_resource_group.integration_rg.name
  short_name          = "EmailFCITech"

  email_receiver {
    name                    = "sendtooperations"
    email_address           = data.azurerm_key_vault_secret.monitor_fci_tech_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "slack_fci_tech" {
  name                = "SlackFirmaConIoTech"
  resource_group_name = azurerm_resource_group.integration_rg.name
  short_name          = "SlackFCITech"

  email_receiver {
    name                    = "sendtoslack"
    email_address           = data.azurerm_key_vault_secret.monitor_fci_tech_slack_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "io_sign_user_helathcheck" {
  name                = format("%s-helathcheck", module.io_sign_user_func.name)
  resource_group_name = azurerm_resource_group.backend_rg.name
  scopes              = [module.io_sign_user_func.id]
  description         = format("%s health check status is less than 100", module.io_sign_user_func.name)
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Maximum"
    operator         = "LessThan"
    threshold        = 1
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_fci_tech.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack_fci_tech.id
  }
}

resource "azurerm_portal_dashboard" "io_sign_qtsp_dashboard" {
  name                = format("%s-qtsp-monitor", local.project)
  resource_group_name = azurerm_resource_group.backend_rg.name
  location            = azurerm_resource_group.backend_rg.location
  dashboard_properties = templatefile("dashboards/user-api.json.tpl", {
    website_name            = module.io_sign_user_func.name
    website_id              = module.io_sign_user_func.id
    application_insights_id = data.azurerm_application_insights.application_insights.id
  })

  tags = var.tags
}

resource "azurerm_monitor_scheduled_query_rules_alert" "io_sign_qtsp_avg_async_time" {
  name                = format("%s-qtsp-avg-async-time", local.project)
  resource_group_name = azurerm_resource_group.backend_rg.name
  location            = azurerm_resource_group.backend_rg.location

  data_source_id          = data.azurerm_application_insights.application_insights.id
  description             = format("%s QTSP avg async time is greater than 1s", local.project)
  enabled                 = true
  auto_mitigation_enabled = false

  query = <<-QUERY

customEvents
| where name in ("sr_start", "sr_end")
| summarize span = datetime_diff('second', max(timestamp), min(timestamp)), maxts = max(timestamp) by tostring(customDimensions["sr_id"])
| summarize avg(span) by bin(maxts, 10m)
| render timechart with (xtitle = "timestamp", ytitle= "span")

  QUERY

  severity    = 1
  frequency   = 10
  time_window = 20
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }

  action {
    action_group = [
      azurerm_monitor_action_group.email_fci_tech.id,
      azurerm_monitor_action_group.slack_fci_tech.id,
    ]
  }

  tags = var.tags
}
