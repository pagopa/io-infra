removed {
  lifecycle {
    destroy = false
  }
  from = azurerm_application_insights.application_insights
}

removed {
  lifecycle {
    destroy = false
  }
  from = module.web_test_api
}

removed {
  from = azurerm_log_analytics_workspace.log_analytics_workspace
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_action_group.email
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_action_group.error_action_group
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_action_group.quarantine_error_action_group
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_action_group.slack
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_action_group.trial_system_error_action_group
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_metric_alert.metric_alerts
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_scheduled_query_rules_alert.mailup_alert_rule
  lifecycle {
    destroy = false
  }
}
