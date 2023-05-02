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

# issuer
resource "azurerm_monitor_metric_alert" "io_sign_issuer_http_server_errors" {
  name                = format("%s-http-server-errors", module.io_sign_issuer_func.name)
  resource_group_name = azurerm_resource_group.backend_rg.name
  scopes              = [module.io_sign_issuer_func.id]
  description         = format("%s http server errors", module.io_sign_issuer_func.name)
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
    action_group_id = data.azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_fci_tech.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack_fci_tech.id
  }
}

resource "azurerm_monitor_metric_alert" "io_sign_issuer_response_time" {
  name                = format("%s-response-time", module.io_sign_issuer_func.name)
  resource_group_name = azurerm_resource_group.backend_rg.name
  scopes              = [module.io_sign_issuer_func.id]
  description         = format("%s response time is greater than 1s", module.io_sign_issuer_func.name)
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HttpResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 1
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_fci_tech.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack_fci_tech.id
  }
}

# user
resource "azurerm_monitor_metric_alert" "io_sign_user_http_server_errors" {
  name                = format("%s-http-server-errors", module.io_sign_user_func.name)
  resource_group_name = azurerm_resource_group.backend_rg.name
  scopes              = [module.io_sign_user_func.id]
  description         = format("%s http server errors", module.io_sign_user_func.name)
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
    action_group_id = data.azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_fci_tech.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack_fci_tech.id
  }
}

resource "azurerm_monitor_metric_alert" "io_sign_user_response_time" {
  name                = format("%s-response-time", module.io_sign_user_func.name)
  resource_group_name = azurerm_resource_group.backend_rg.name
  scopes              = [module.io_sign_user_func.id]
  description         = format("%s response time is greater than 1s", module.io_sign_user_func.name)
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HttpResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 1
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_fci_tech.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack_fci_tech.id
  }
}

# support
resource "azurerm_monitor_metric_alert" "io_sign_support_http_server_errors" {
  name                = format("%s-http-server-errors", module.io_sign_support_func.name)
  resource_group_name = azurerm_resource_group.backend_rg.name
  scopes              = [module.io_sign_support_func.id]
  description         = format("%s http server errors", module.io_sign_support_func.name)
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
    action_group_id = data.azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_fci_tech.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack_fci_tech.id
  }
}

resource "azurerm_monitor_metric_alert" "io_sign_support_response_time" {
  name                = format("%s-response-time", module.io_sign_support_func.name)
  resource_group_name = azurerm_resource_group.backend_rg.name
  scopes              = [module.io_sign_support_func.id]
  description         = format("%s response time is greater than 1s", module.io_sign_support_func.name)
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HttpResponseTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 1
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.email_fci_tech.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack_fci_tech.id
  }
}
