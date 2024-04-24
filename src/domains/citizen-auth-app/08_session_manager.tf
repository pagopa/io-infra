resource "azurerm_resource_group" "session_manager_rg" {
  name     = format("%s-session-manager-rg", local.common_session_manager_project)
  location = var.session_manager_location

  tags = var.tags
}

#################################
## Session Manager App service ##
#################################
locals {
  app_settings_common = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080

    WEBSITE_NODE_DEFAULT_VERSION = "20.12.2"
    WEBSITE_RUN_FROM_PACKAGE     = "1"
    WEBSITE_VNET_ROUTE_ALL       = "1"

    // ENVIRONMENT
    NODE_ENV = "production"

    FETCH_KEEPALIVE_ENABLED = "true"
    // see https://github.com/MicrosoftDocs/azure-docs/issues/29600#issuecomment-607990556
    // and https://docs.microsoft.com/it-it/azure/app-service/app-service-web-nodejs-best-practices-and-troubleshoot-guide#scenarios-and-recommendationstroubleshooting
    // FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL should not exceed 120000 (app service socket timeout)
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL = "110000"
    // (FETCH_KEEPALIVE_MAX_SOCKETS * number_of_node_processes) should not exceed 160 (max sockets per VM)
    FETCH_KEEPALIVE_MAX_SOCKETS         = "128"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # REDIS AUTHENTICATION
    REDIS_URL      = data.azurerm_redis_cache.core_domain_redis_common.hostname
    REDIS_PORT     = data.azurerm_redis_cache.core_domain_redis_common.ssl_port
    REDIS_PASSWORD = data.azurerm_redis_cache.core_domain_redis_common.primary_access_key
  }
}

module "session_manager" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v8.4.0"

  # App service plan
  plan_type = "internal"
  plan_name = format("%s-session-manager-plan", local.common_session_manager_project)
  sku_name  = var.session_manager_plan_sku_name

  # App service
  name                = format("%s-session-manager", local.common_session_manager_project)
  resource_group_name = azurerm_resource_group.session_manager_rg.name
  location            = azurerm_resource_group.session_manager_rg.location

  always_on                    = true
  node_version                 = "18-lts"
  app_command_line             = "npm run start"
  health_check_path            = "/healthcheck"
  health_check_maxpingfailures = 3

  app_settings = local.app_settings_common

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
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot?ref=v8.4.0"

  app_service_id   = module.session_manager.id
  app_service_name = module.session_manager.name

  name                = "staging"
  resource_group_name = azurerm_resource_group.session_manager_rg.name
  location            = azurerm_resource_group.session_manager_rg.location

  always_on         = true
  node_version      = "18-lts"
  app_command_line  = "npm run start"
  health_check_path = "/healthcheck"

  app_settings = local.app_settings_common

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
  name                = format("%s-autoscale", module.session_manager.name)
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