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

