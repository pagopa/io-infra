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

data "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = "io-p-rg-common"
  name                = "${var.prefix}${var.env_short}error"
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

resource "azurerm_monitor_scheduled_query_rules_alert" "rejected_requests" {
  name                = format("%s-rejected-requests", local.project)
  resource_group_name = azurerm_resource_group.backend_rg.name
  location            = azurerm_resource_group.backend_rg.location

  data_source_id          = data.azurerm_application_insights.application_insights.id
  description             = "[IO-SIGN] There are REJECTED signature requests. Runbook: https://pagopa.atlassian.net/wiki/spaces/SFEQS/pages/935592503/Richieste+di+firma+in+stato+REJECTED"
  enabled                 = true
  auto_mitigation_enabled = false

  query = <<-QUERY
customEvents
| where name == "io.sign.signature_request.rejected"
| where customDimensions.environment == "DEFAULT"
| summarize AggregatedValue = count() by bin(timestamp, 30m)
| where AggregatedValue > 1
  QUERY

  severity    = 3
  frequency   = 30
  time_window = 30

  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }

  action {
    action_group = [
      azurerm_monitor_action_group.email_fci_tech.id,
      azurerm_monitor_action_group.slack_fci_tech.id,
      data.azurerm_monitor_action_group.error_action_group.id
    ]
  }

  tags = var.tags
}

resource "azurerm_monitor_scheduled_query_rules_alert" "rejected_test_requests" {
  name                = format("%s-rejected-test-requests", local.project)
  resource_group_name = azurerm_resource_group.backend_rg.name
  location            = azurerm_resource_group.backend_rg.location

  data_source_id          = data.azurerm_application_insights.application_insights.id
  description             = "[IO-SIGN] There are REJECTED signature requests in TEST environment. No action required"
  enabled                 = true
  auto_mitigation_enabled = false

  query = <<-QUERY
customEvents
| where name == "io.sign.signature_request.rejected"
| where customDimensions.environment == "TEST"
| summarize AggregatedValue = count() by bin(timestamp, 30m)
| where AggregatedValue > 1
  QUERY

  severity    = 3
  frequency   = 30
  time_window = 30

  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }

  action {
    action_group = [
      azurerm_monitor_action_group.slack_fci_tech.id
    ]
  }

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "io_sign_backoffice_func" {
  name                = format("%s-autoscale", module.io_sign_backoffice_func.name)
  resource_group_name = azurerm_resource_group.backend_rg.name
  location            = azurerm_resource_group.backend_rg.location
  target_resource_id  = module.io_sign_backoffice_func.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.io_sign_backoffice_func.autoscale_default
      minimum = var.io_sign_backoffice_func.autoscale_minimum
      maximum = var.io_sign_backoffice_func.autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.io_sign_backoffice_func.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.io_sign_backoffice_app.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.io_sign_backoffice_func.app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 60
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.io_sign_backoffice_func.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.io_sign_backoffice_app.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.io_sign_backoffice_func.app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 30
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }
  }
}

