removed {
  lifecycle {
    destroy = false
  }
  from = module.monitoring_weu.azurerm_application_insights.appi
}

removed {
  lifecycle {
    destroy = false
  }
  from = module.monitoring_weu.azurerm_application_insights_standard_web_test.web_tests
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
  from = module.monitoring_weu.azurerm_monitor_action_group.trial_system_error
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
