resource "azurerm_monitor_autoscale_setting" "backendli" {
  count               = var.is_li ? 1 : 0
  name                = "${module.appservice_app_backend.name}-autoscale"
  resource_group_name = var.resource_groups.linux
  location            = var.location
  target_resource_id  = module.appservice_app_backend.plan_id

  # Scaling strategy
  # 05 - 19,30 -> min 3
  # 19,30 - 23 -> min 4
  # 23 - 05 -> min 2
  dynamic "profile" {
    for_each = local.autoscale_profiles
    iterator = profile_info

    content {
      name = profile_info.value.name

      dynamic "recurrence" {
        for_each = profile_info.value.recurrence != null ? [profile_info.value.recurrence] : []
        iterator = recurrence_info

        content {
          timezone = "W. Europe Standard Time"
          hours    = [recurrence_info.value.hours]
          minutes  = [recurrence_info.value.minutes]
          days = [
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
            "Sunday"
          ]
        }
      }

      capacity {
        default = profile_info.value.capacity.default
        minimum = profile_info.value.capacity.minimum
        maximum = profile_info.value.capacity.maximum
      }

      # Increase rules

      rule {
        metric_trigger {
          metric_name              = "Requests"
          metric_resource_id       = module.appservice_app_backend.id
          metric_namespace         = "microsoft.web/sites"
          time_grain               = "PT1M"
          statistic                = "Average"
          time_window              = "PT5M"
          time_aggregation         = "Average"
          operator                 = "GreaterThan"
          threshold                = 4000
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
          metric_resource_id       = module.appservice_app_backend.plan_id
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
          value     = "2"
          cooldown  = "PT5M"
        }
      }

      # Decrease rules

      rule {
        metric_trigger {
          metric_name              = "Requests"
          metric_resource_id       = module.appservice_app_backend.id
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
          cooldown  = "PT30M"
        }
      }

      rule {
        metric_trigger {
          metric_name              = "CpuPercentage"
          metric_resource_id       = module.appservice_app_backend.plan_id
          metric_namespace         = "microsoft.web/serverfarms"
          time_grain               = "PT1M"
          statistic                = "Average"
          time_window              = "PT5M"
          time_aggregation         = "Average"
          operator                 = "LessThan"
          threshold                = 15
          divide_by_instance_count = false
        }

        scale_action {
          direction = "Decrease"
          type      = "ChangeCount"
          value     = "1"
          cooldown  = "PT30M"
        }
      }
    }
  }
}

locals {
  autoscale_profiles = var.autoscale != null ? [
    {
      name = "{\"name\":\"default\",\"for\":\"evening\"}",

      recurrence = {
        hours   = 22
        minutes = 59
      }

      capacity = {
        default = var.autoscale.default + 1
        minimum = var.autoscale.minimum + 1
        maximum = var.autoscale.maximum
      }
    },
    {
      name = "{\"name\":\"default\",\"for\":\"night\"}",

      recurrence = {
        hours   = 5
        minutes = 0
      }

      capacity = {
        default = var.autoscale.default + 1
        minimum = var.autoscale.minimum + 1
        maximum = var.autoscale.maximum
      }
    },
    {
      name = "evening"

      recurrence = {
        hours   = 19
        minutes = 30
      }

      capacity = {
        default = var.autoscale.default + 2
        minimum = var.autoscale.minimum + 2
        maximum = var.autoscale.maximum
      }
    },
    {
      name = "night"

      recurrence = {
        hours   = 23
        minutes = 0
      }

      capacity = {
        default = var.autoscale.default
        minimum = var.autoscale.minimum
        maximum = var.autoscale.maximum
      }
    }
  ] : null
}