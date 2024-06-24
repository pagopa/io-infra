

###########

resource "azurerm_resource_group" "session_manager_rg" {
  name     = format("%s-session-manager-rg-01", local.common_project_itn)
  location = local.itn_location

  tags = var.tags
}

#################################
## Session Manager App service ##
#################################

module "session_manager" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service?ref=v8.7.0"

  # App service plan
  plan_type = "internal"
  plan_name = format("%s-session-manager-asp-02", local.common_project)
  sku_name  = var.session_manager_plan_sku_name

  # App service
  name                = local.app_name
  resource_group_name = azurerm_resource_group.session_manager_rg.name
  location            = var.location

  always_on                    = true
  node_version                 = "18-lts"
  app_command_line             = "npm run start"
  health_check_path            = "/healthcheck"
  health_check_maxpingfailures = 3

  app_settings = merge(
    local.app_settings_common,
    {
      APPINSIGHTS_CLOUD_ROLE_NAME = local.app_name
    }
  )
  sticky_settings = concat(["APPINSIGHTS_CLOUD_ROLE_NAME"])


  allowed_subnets = [
    data.azurerm_subnet.apim_v2_snet.id,
    data.azurerm_subnet.appgateway_snet.id
    // TODO: add proxy subnet
  ]
  allowed_ips = []

  subnet_id        = module.session_manager_snet.id
  vnet_integration = true

  tags = var.tags
}

## staging slot
module "session_manager_staging" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service_slot?ref=v8.7.0"

  app_service_id   = module.session_manager.id
  app_service_name = module.session_manager.name

  name                = "staging"
  resource_group_name = azurerm_resource_group.session_manager_rg.name
  location            = var.location

  always_on         = true
  node_version      = "18-lts"
  app_command_line  = "npm run start"
  health_check_path = "/healthcheck"

  app_settings = merge(
    local.app_settings_common,
    {
      APPINSIGHTS_CLOUD_ROLE_NAME = "${module.session_manager.name}-staging"
    }
  )

  allowed_subnets = [
    # self hosted runners subnet
    data.azurerm_subnet.self_hosted_runner_snet.id,
    #
    data.azurerm_subnet.apim_v2_snet.id,
    data.azurerm_subnet.appgateway_snet.id
    // TODO: add proxy subnet
  ]
  allowed_ips = []

  subnet_id        = module.session_manager_snet.id
  vnet_integration = true

  tags = var.tags
}

## autoscaling
resource "azurerm_monitor_autoscale_setting" "session_manager_autoscale_setting" {
  name                = format("%s-autoscale-01", module.session_manager.name)
  resource_group_name = azurerm_resource_group.session_manager_rg.name
  location            = azurerm_resource_group.session_manager_rg.location
  target_resource_id  = module.session_manager.plan_id

  profile {
    name = "default"

    capacity {
      default = var.session_manager_autoscale_settings.autoscale_default
      minimum = var.session_manager_autoscale_settings.autoscale_minimum
      maximum = var.session_manager_autoscale_settings.autoscale_maximum
    }

    # Increase rules

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.session_manager.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT1M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.session_manager.plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT1M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 40
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT1M"
      }
    }

    # Decrease rules

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.session_manager.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT15M"
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
        metric_resource_id       = module.session_manager.plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT15M"
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
