locals {
  app_backend_legacy = {
    app_settings_l1 = {
      IS_APPBACKENDLI = "false"
      // FUNCTIONS
      API_URL              = "http://${data.azurerm_function_app.fnapp_app1.default_hostname}/api/v1"
      APP_MESSAGES_API_URL = "https://${module.app_messages_function[0].default_hostname}/api/v1"
    }
    app_settings_l2 = {
      IS_APPBACKENDLI = "false"
      // FUNCTIONS
      API_URL              = "http://${data.azurerm_function_app.fnapp_app2.default_hostname}/api/v1"
      APP_MESSAGES_API_URL = "https://${module.app_messages_function[1].default_hostname}/api/v1"
    }
    app_settings_li = {
      IS_APPBACKENDLI = "true"
      // FUNCTIONS
      API_URL              = "http://${data.azurerm_function_app.fnapp_app1.default_hostname}/api/v1" # not used
      APP_MESSAGES_API_URL = "https://${module.app_messages_function[0].default_hostname}/api/v1"     # not used
    }

    app_backend_test_urls = [
      {
        # https://io-p-app-appbackendl1.azurewebsites.net/info
        name        = module.appservice_app_backendl1.default_site_hostname,
        host        = module.appservice_app_backendl1.default_site_hostname,
        path        = "/info",
        http_status = 200,
      },
      {
        # https://io-p-app-appbackendl2.azurewebsites.net/info
        name        = module.appservice_app_backendl2.default_site_hostname,
        host        = module.appservice_app_backendl2.default_site_hostname,
        path        = "/info",
        http_status = 200,
      },
      {
        # https://io-p-app-appbackendli.azurewebsites.net/info
        name        = module.appservice_app_backendli.default_site_hostname,
        host        = module.appservice_app_backendli.default_site_hostname,
        path        = "/info",
        http_status = 200,
      },
    ]
  }


}

### Common resources

resource "azurerm_resource_group" "rg_linux" {
  name     = format("%s-rg-linux", local.project)
  location = var.location

  tags = var.tags
}


## app_backendl1

module "app_backendl1_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.28"
  name                 = "appbackendl1"
  address_prefixes     = var.cidr_subnet_appbackendl1
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

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

#tfsec:ignore:azure-appservice-authentication-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
#tfsec:ignore:azure-appservice-require-client-cert:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "appservice_app_backendl1" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.9.1"

  # App service plan
  plan_type     = "internal"
  plan_name     = format("%s-plan-appappbackendl1", local.project)
  plan_kind     = "Linux"
  plan_reserved = true # Mandatory for Linux plan
  plan_sku_tier = var.app_backend_plan_sku_tier
  plan_sku_size = var.app_backend_plan_sku_size

  # App service
  name                = format("%s-app-appbackendl1", local.project)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on         = true
  linux_fx_version  = "NODE|14-lts"
  app_command_line  = "node /home/site/wwwroot/src/server.js"
  health_check_path = null

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend_legacy.app_settings_l1,
  )

  allowed_subnets = [
    data.azurerm_subnet.fnapp_admin_subnet_out.id,
    data.azurerm_subnet.fnapp_services_subnet_out.id,
    module.appgateway_snet.id,
    module.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  subnet_id        = module.app_backendl1_snet.id
  vnet_integration = true

  tags = var.tags
}

module "appservice_app_backendl1_slot_staging" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service_slot?ref=v2.9.1"

  # App service plan
  app_service_plan_id = module.appservice_app_backendl1.plan_id
  app_service_id      = module.appservice_app_backendl1.id
  app_service_name    = module.appservice_app_backendl1.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on         = true
  linux_fx_version  = "NODE|14-lts"
  app_command_line  = "node /home/site/wwwroot/src/server.js"
  health_check_path = null

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend_legacy.app_settings_l1,
  )

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
    data.azurerm_subnet.fnapp_admin_subnet_out.id,
    data.azurerm_subnet.fnapp_services_subnet_out.id,
    module.appgateway_snet.id,
    module.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  subnet_id        = module.app_backendl1_snet.id
  vnet_integration = true

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "appservice_app_backendl1" {
  name                = format("%s-autoscale", module.appservice_app_backendl1.name)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location
  target_resource_id  = module.appservice_app_backendl1.plan_id

  profile {
    name = "default"

    capacity {
      default = var.app_backend_autoscale_default
      minimum = var.app_backend_autoscale_minimum
      maximum = var.app_backend_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendl1.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3500
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
        metric_resource_id       = module.appservice_app_backendl1.plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 45
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
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendl1.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.appservice_app_backendl1.plan_id
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
        cooldown  = "PT20M"
      }
    }
  }
}

## app_backendl2

module "app_backendl2_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.28"
  name                 = "appbackendl2"
  address_prefixes     = var.cidr_subnet_appbackendl2
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

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

#tfsec:ignore:azure-appservice-authentication-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
#tfsec:ignore:azure-appservice-require-client-cert:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "appservice_app_backendl2" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.9.1"

  # App service plan
  plan_type     = "internal"
  plan_name     = format("%s-plan-appappbackendl2", local.project)
  plan_kind     = "Linux"
  plan_reserved = true # Mandatory for Linux plan
  plan_sku_tier = var.app_backend_plan_sku_tier
  plan_sku_size = var.app_backend_plan_sku_size

  # App service
  name                = format("%s-app-appbackendl2", local.project)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on         = true
  linux_fx_version  = "NODE|14-lts"
  app_command_line  = "node /home/site/wwwroot/src/server.js"
  health_check_path = null

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend_legacy.app_settings_l2,
  )

  allowed_subnets = [
    data.azurerm_subnet.fnapp_admin_subnet_out.id,
    data.azurerm_subnet.fnapp_services_subnet_out.id,
    module.appgateway_snet.id,
    module.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  subnet_id        = module.app_backendl2_snet.id
  vnet_integration = true

  tags = var.tags
}

module "appservice_app_backendl2_slot_staging" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service_slot?ref=v2.9.1"

  # App service plan
  app_service_plan_id = module.appservice_app_backendl2.plan_id
  app_service_id      = module.appservice_app_backendl2.id
  app_service_name    = module.appservice_app_backendl2.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on         = true
  linux_fx_version  = "NODE|14-lts"
  app_command_line  = "node /home/site/wwwroot/src/server.js"
  health_check_path = null

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend_legacy.app_settings_l2,
  )

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
    data.azurerm_subnet.fnapp_admin_subnet_out.id,
    data.azurerm_subnet.fnapp_services_subnet_out.id,
    module.appgateway_snet.id,
    module.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  subnet_id        = module.app_backendl2_snet.id
  vnet_integration = true

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "appservice_app_backendl2" {
  name                = format("%s-autoscale", module.appservice_app_backendl2.name)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location
  target_resource_id  = module.appservice_app_backendl2.plan_id

  profile {
    name = "default"

    capacity {
      default = var.app_backend_autoscale_default
      minimum = var.app_backend_autoscale_minimum
      maximum = var.app_backend_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendl2.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3500
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
        metric_resource_id       = module.appservice_app_backendl2.plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 45
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
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendl2.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.appservice_app_backendl2.plan_id
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
        cooldown  = "PT20M"
      }
    }
  }
}

## app_backendli

module "app_backendli_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.28"
  name                 = "appbackendli"
  address_prefixes     = var.cidr_subnet_appbackendli
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name

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

#tfsec:ignore:azure-appservice-authentication-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
#tfsec:ignore:azure-appservice-require-client-cert:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "appservice_app_backendli" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.9.1"

  # App service plan
  plan_type     = "internal"
  plan_name     = format("%s-plan-appappbackendli", local.project)
  plan_kind     = "Linux"
  plan_reserved = true # Mandatory for Linux plan
  plan_sku_tier = var.app_backend_plan_sku_tier
  plan_sku_size = var.app_backend_plan_sku_size

  # App service
  name                = format("%s-app-appbackendli", local.project)
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on         = true
  linux_fx_version  = "NODE|14-lts"
  app_command_line  = "node /home/site/wwwroot/src/server.js"
  health_check_path = null

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend_legacy.app_settings_li,
  )

  allowed_subnets = [
    data.azurerm_subnet.fnapp_admin_subnet_out.id,
    data.azurerm_subnet.fnapp_services_subnet_out.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  subnet_id        = module.app_backendli_snet.id
  vnet_integration = true

  tags = var.tags
}

module "appservice_app_backendli_slot_staging" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service_slot?ref=v2.9.1"

  # App service plan
  app_service_plan_id = module.appservice_app_backendli.plan_id
  app_service_id      = module.appservice_app_backendli.id
  app_service_name    = module.appservice_app_backendli.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.rg_linux.name
  location            = azurerm_resource_group.rg_linux.location

  always_on         = true
  linux_fx_version  = "NODE|14-lts"
  app_command_line  = "node /home/site/wwwroot/src/server.js"
  health_check_path = null

  app_settings = merge(
    local.app_backend.app_settings_common,
    local.app_backend_legacy.app_settings_li,
  )

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
    data.azurerm_subnet.fnapp_admin_subnet_out.id,
    data.azurerm_subnet.fnapp_services_subnet_out.id,
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

  profile {
    name = "default"

    capacity {
      default = var.app_backend_autoscale_default
      minimum = var.app_backend_autoscale_minimum
      maximum = var.app_backend_autoscale_maximum
    }

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
        threshold                = 3500
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
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_app_backendli.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }
  }
}


## web availabolity test
module "app_backend_web_test_api" {
  for_each = { for v in local.app_backend_legacy_test_urls : v.name => v if v != null }
  source   = "git::https://github.com/pagopa/azurerm.git//application_insights_web_test_preview?ref=v2.9.1"

  subscription_id                   = data.azurerm_subscription.current.subscription_id
  name                              = format("%s-test", each.value.name)
  location                          = data.azurerm_resource_group.monitor_rg.location
  resource_group                    = data.azurerm_resource_group.monitor_rg.name
  application_insight_name          = data.azurerm_application_insights.application_insights.name
  request_url                       = format("https://%s%s", each.value.host, each.value.path)
  expected_http_status              = each.value.http_status
  ssl_cert_remaining_lifetime_check = 7

  actions = [
    {
      action_group_id = azurerm_monitor_action_group.email.id,
    },
    {
      action_group_id = azurerm_monitor_action_group.slack.id,
    },
  ]

}
