resource "azurerm_monitor_autoscale_setting" "function_services_autoscale" {
  name                = format("%s-autoscale", module.function_services_dx.function_app.function_app.name)
  resource_group_name = data.azurerm_resource_group.services_itn_rg.name
  location            = var.location_itn
  target_resource_id  = module.function_services_dx.function_app.plan.id

  profile {
    name = "default"

    capacity {
      default = var.function_services_autoscale_default
      minimum = var.function_services_autoscale_minimum
      maximum = var.function_services_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_services_dx.function_app.function_app.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 2500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "3"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_services_dx.function_app.plan.id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 40
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "3"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_services_dx.function_app.function_app.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 1500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.function_services_dx.function_app.plan.id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 25
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }
  }
}


module "function_services_autoscale" {
  source  = "pagopa-dx/azure-app-service-plan-autoscaler/azurerm"
  version = "~> 2.0"

  resource_group_name = module.function_services.function_app.resource_group_name
  location            = var.location
  app_service_plan_id = module.function_services.function_app.plan.id
  target_service = {
    function_apps = [
      { id = module.function_services.function_app.function_app.id }
    ]
  }

  scheduler = {
    normal_load = {
      minimum = 4
      default = 10
    },
    maximum = 30
  }

  scale_metrics = {
    requests = {
      #################
      # scale out
      #################
      statistic_increase   = "Max"
      time_window_increase = 1
      time_aggregation     = "Maximum"
      upper_threshold      = 2500
      increase_by          = 2
      cooldown_increase    = 3
      #################
      # scale in
      #################
      statistic_decrease        = "Average"
      time_window_decrease      = 5
      time_aggregation_decrease = "Average"
      lower_threshold           = 500
      decrease_by               = 1
      cooldown_decrease         = 3
    }
    cpu = {
      #################
      # scale out
      #################
      statistic_increase        = "Max"
      time_window_increase      = 1
      time_aggregation_increase = "Maximum"
      upper_threshold           = 40
      increase_by               = 2
      cooldown_increase         = 3
      #################
      # scale in
      #################
      statistic_decrease        = "Average"
      time_window_decrease      = 5
      time_aggregation_decrease = "Average"
      lower_threshold           = 15
      decrease_by               = 1
      cooldown_decrease         = 3
    }
    memory = null
  }

  tags = var.tags
}

