module "function_assets_cdn_autoscale" {
  source              = "pagopa-dx/azure-app-service-plan-autoscaler/azurerm"
  version             = "~> 0.0"
  resource_group_name = azurerm_resource_group.function_assets_cdn_itn_rg.name
  target_service = {
    function_app_name = module.function_assets_cdn_itn.function_app.name
  }
  scheduler = {
    normal_load = {
      minimum = 2
      default = 2
    },
    maximum = 10
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
      cooldown_decrease         = 2
    }
    cpu = {
      upper_threshold           = 50
      lower_threshold           = 15
      increase_by               = 3
      decrease_by               = 1
      cooldown_increase         = 1
      cooldown_decrease         = 2
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