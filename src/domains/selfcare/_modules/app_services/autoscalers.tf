
resource "azurerm_monitor_autoscale_setting" "appservice_selfcare_be_common" {
  name                = "${azurerm_service_plan.selfcare_be_common.name}-autoscale"
  resource_group_name = azurerm_service_plan.selfcare_be_common.resource_group_name
  location            = azurerm_service_plan.selfcare_be_common.location
  target_resource_id  = azurerm_service_plan.selfcare_be_common.id

  profile {
    name = "default"

    capacity {
      default = 1
      minimum = 1
      maximum = 10
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = azurerm_service_plan.selfcare_be_common.id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 70
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "5"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = azurerm_service_plan.selfcare_be_common.id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT20M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 30
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "5"
        cooldown  = "PT5M"
      }
    }
  }
}
