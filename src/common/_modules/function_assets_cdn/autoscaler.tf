module "function_assets_cdn_autoscale" {
  source              = "pagopa-dx/azure-app-service-plan-autoscaler/azurerm"
  version             = "~> 2.0"
  resource_group_name = module.function_assets_cdn_itn.function_app.resource_group_name
  location            = var.location_itn
  app_service_plan_id = module.function_assets_cdn_itn.function_app.plan.id
  target_service = {
    function_apps = [
      { id = module.function_assets_cdn_itn.function_app.function_app.id }
    ]
  }
  scheduler = {
    normal_load = {
      minimum = 4
      default = 4
    },
    maximum = 30
  }
  scale_metrics = {
    requests = {
      statistic_increase        = "Max"
      time_window_increase      = 1
      time_aggregation          = "Maximum"
      upper_threshold           = 2500
      increase_by               = 2
      cooldown_increase         = 1
      statistic_decrease        = "Average"
      time_window_decrease      = 5
      time_aggregation_decrease = "Average"
      lower_threshold           = 200
      decrease_by               = 1
      cooldown_decrease         = 5
    }
    cpu = {
      upper_threshold           = 50
      lower_threshold           = 15
      increase_by               = 3
      decrease_by               = 1
      cooldown_increase         = 1
      cooldown_decrease         = 5
      statistic_increase        = "Max"
      statistic_decrease        = "Average"
      time_aggregation_increase = "Maximum"
      time_aggregation_decrease = "Average"
      time_window_increase      = 1
      time_window_decrease      = 5
    }
    memory = null
  }
  tags = var.tags
}