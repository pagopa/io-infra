## app_backendli

module "app_backendli_snet" {
  source                                    = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.27.0"
  name                                      = "appbackendli"
  address_prefixes                          = var.cidr_subnet_appbackendli
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = data.azurerm_virtual_network.common.name
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_subnet_nat_gateway_association" "app_backendli_snet" {
  nat_gateway_id = data.azurerm_nat_gateway.ng.id
  subnet_id      = module.app_backendli_snet.id
}

module "appservice_app_backendli" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service?ref=v8.31.0"

  # App service plan
  plan_type = "internal"
  plan_name = format("%s-plan-appappbackendli", local.project)
  sku_name  = var.app_backend_plan_sku_size

  # App service
  name                = format("%s-app-appbackendli", local.project)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on                    = true
  node_version                 = "18-lts"
  app_command_line             = local.app_backend.app_command_line
  health_check_path            = "/ping"
  health_check_maxpingfailures = 3

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_li,
  )

  ip_restriction_default_action = "Deny"

  allowed_subnets = [
    data.azurerm_subnet.services_snet[0].id,
    data.azurerm_subnet.services_snet[1].id,
    data.azurerm_subnet.admin_snet.id,
    data.azurerm_subnet.functions_fast_login_snet.id,
    data.azurerm_subnet.functions_service_messages_snet.id,
    data.azurerm_subnet.itn_msgs_sending_func_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
    local.aks_ips,
  )

  subnet_id        = module.app_backendli_snet.id
  vnet_integration = true

  tags = var.tags
}

module "appservice_app_backendli_slot_staging" {
  source = "github.com/pagopa/terraform-azurerm-v3//app_service_slot?ref=v8.31.0"

  # App service plan
  app_service_id   = module.appservice_app_backendli.id
  app_service_name = module.appservice_app_backendli.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on         = true
  node_version      = "18-lts"
  app_command_line  = local.app_backend.app_command_line
  health_check_path = "/ping"

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend.app_settings_li,
  )

  ip_restriction_default_action = "Deny"

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet.id,
    data.azurerm_subnet.services_snet[0].id,
    data.azurerm_subnet.services_snet[1].id,
    data.azurerm_subnet.admin_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  subnet_id        = module.app_backendli_snet.id
  vnet_integration = true

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "appservice_app_backendli" {
  name                = format("%s-autoscale", module.appservice_app_backendli.name)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location
  target_resource_id  = module.appservice_app_backendli.plan_id

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
          metric_resource_id       = module.appservice_app_backendli.id
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
          metric_resource_id       = module.appservice_app_backendli.plan_id
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
          metric_resource_id       = module.appservice_app_backendli.id
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
          metric_resource_id       = module.appservice_app_backendli.plan_id
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