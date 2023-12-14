locals {
  app_service_plan_sku_premium_regex = "^P[[:digit:]](m?)v[[:digit:]]$"

  continua_appsvc_settings = {
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"

    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.application_insights.instrumentation_key

    NODE_ENV = "production"
    PORT     = "3000"

    # Fallback
    FALLBACK_URL            = "https://io.italia.it"
    FALLBACK_URL_ON_IOS     = "https://apps.apple.com/it/app/io/id1501681835"
    FALLBACK_URL_ON_ANDROID = "https://play.google.com/store/apps/details?id=it.pagopa.io.app"

    # iOS
    IOS_APP_ID     = "M2X5YQ4BJ7"
    IOS_BUNDLE_ID  = "it.pagopa.app.io"
    IOS_APP_SCHEME = "ioit://"

    # Android
    ANDROID_PACKAGE_NAME              = "it.pagopa.io.app"
    ANDROID_SHA_256_CERT_FINGERPRINTS = "7D:E4:FE:3E:AA:E0:83:FF:CD:8B:07:03:01:E8:65:02:D3:F1:EA:D1:DD:66:AC:14:2B:AD:7C:54:47:55:4F:82"
  }
}

resource "azurerm_resource_group" "continua_rg" {
  name     = format("%s-continua-rg", local.project)
  location = var.location

  tags = var.tags
}

module "continua_common_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.28.0"

  name                                      = format("%s-continua-common-snet", local.project)
  address_prefixes                          = var.cidr_subnet_continua
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = false
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

resource "azurerm_service_plan" "continua" {
  name                   = format("%s-app-continua", local.project)
  resource_group_name    = azurerm_resource_group.continua_rg.name
  location               = azurerm_resource_group.continua_rg.location
  os_type                = "Linux"
  sku_name               = var.continua_appservice_sku
  zone_balancing_enabled = true

  tags = var.tags

  # TODO remove when the terraform provider for Azure will support SKU P0v3
  # Up to then, the work-around is defining as P1v3 and changing via console
  lifecycle {
    ignore_changes = [
      sku_name,
    ]
  }
}

module "appservice_continua" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v7.33.0"

  name                = format("%s-app-continua", local.project)
  resource_group_name = azurerm_resource_group.continua_rg.name
  location            = azurerm_resource_group.continua_rg.location

  app_command_line             = "yarn start"
  health_check_path            = "/health"
  health_check_maxpingfailures = 3
  node_version                 = "18-lts"
  app_settings                 = local.continua_appsvc_settings
  sticky_settings              = []

  always_on = true
  plan_id   = azurerm_service_plan.continua.id
  plan_type = "external"

  vnet_integration = true
  subnet_id        = module.continua_common_snet.id
  allowed_subnets = [
    module.appgateway_snet.id,
  ]

  tags = var.tags
}

module "appservice_continua_slot_staging" {
  count  = can(regex(local.app_service_plan_sku_premium_regex, var.continua_appservice_sku)) ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot?ref=v7.28.0"

  name                = "staging"
  resource_group_name = azurerm_resource_group.continua_rg.name
  location            = azurerm_resource_group.continua_rg.location

  always_on        = true
  app_service_id   = module.appservice_continua.id
  app_service_name = module.appservice_continua.name

  app_command_line  = "yarn start"
  app_settings      = local.continua_appsvc_settings
  health_check_path = "/health"
  node_version      = "18-lts"

  vnet_integration = true
  subnet_id        = module.continua_common_snet.id
  allowed_subnets = [
    module.appgateway_snet.id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "appservice_continua" {
  name                = format("%s-autoscale", azurerm_service_plan.continua.name)
  resource_group_name = azurerm_resource_group.continua_rg.name
  location            = azurerm_resource_group.continua_rg.location
  target_resource_id  = azurerm_service_plan.continua.id

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
        metric_resource_id       = azurerm_service_plan.continua.id
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
        metric_resource_id       = azurerm_service_plan.continua.id
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
