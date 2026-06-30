# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

# MONITORING ITN

removed {
  from = module.monitoring_itn.azurerm_application_insights_standard_web_test.web_tests

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_itn.azurerm_application_insights.appi

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_itn.azurerm_key_vault_secret.appinsights_connection_string

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_itn.azurerm_key_vault_secret.appinsights_instrumentation_key

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_itn.azurerm_log_analytics_workspace.log

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_itn.azurerm_monitor_action_group.email

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_itn.azurerm_monitor_action_group.error

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_itn.azurerm_monitor_action_group.quarantine_error

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_itn.azurerm_monitor_action_group.slack

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_itn.azurerm_monitor_metric_alert.metric_alerts

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_itn.azurerm_monitor_scheduled_query_rules_alert_v2.mailup

  lifecycle {
    destroy = false
  }
}

# MONITORING WEU

removed {
  from = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_weu.azurerm_application_insights.appi

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_weu.azurerm_key_vault_secret.appinsights_connection_string

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_weu.azurerm_key_vault_secret.appinsights_instrumentation_key

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_weu.azurerm_log_analytics_workspace.log

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_weu.azurerm_monitor_action_group.email

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_weu.azurerm_monitor_action_group.error

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_weu.azurerm_monitor_action_group.quarantine_error

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_weu.azurerm_monitor_action_group.slack

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_weu.azurerm_monitor_metric_alert.metric_alerts

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.monitoring_weu.azurerm_monitor_scheduled_query_rules_alert_v2.mailup

  lifecycle {
    destroy = false
  }
}