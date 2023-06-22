resource "azurerm_resource_group" "fims_rg" {
  count    = var.fims_enabled ? 1 : 0
  name     = format("%s-fims-rg", local.common_project)
  location = var.location
  tags     = var.tags
}

data "azurerm_key_vault_secret" "mongodb_connection_string_fims" {
  name         = "io-p-fims-mongodb-account-connection-string"
  key_vault_id = data.azurerm_key_vault.kv.id
}

locals {
  fims = {
    app_command_line = "npm run start"

    app_settings_common = {
      # No downtime on slots swap
      WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
      WEBSITE_RUN_FROM_PACKAGE                        = "1"
      WEBSITE_DNS_SERVER                              = "168.63.129.16"
      WEBSITE_HEALTHCHECK_MAXPINGFAILURES             = "3"

      APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.application_insights.instrumentation_key

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

      SERVER_HOSTNAME               = "localhost"
      LOG_LEVEL                     = "debug"
      APPLICATION_NAME              = "io-openid-provider"
      IO_BACKEND_BASE_URL           = "https://app-backend.io.pagopa.it"
      VERSION                       = "0.0.1"
      MONGODB_URL                   = data.azurerm_key_vault_secret.mongodb_connection_string_fims.value
      AUTHENTICATION_COOKIE_KEY     = "X-IO-FIMS-Token"
      GRANT_TTL_IN_SECONDS          = "86400"
      ISSUER                        = "http://localhost:3001"     #TBD with domain value
      COOKIES_KEY                   = "just-for-testing-purposes" #TBD with vault value
      ENABLE_FEATURE_REMEMBER_GRANT = "true"
    }
  }
}

module "fims_snet" {
  count                                     = var.fims_enabled ? 1 : 0
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.15"
  name                                      = "fims"
  address_prefixes                          = var.cidr_subnet_fims
  resource_group_name                       = azurerm_resource_group.fims_rg[0].name
  virtual_network_name                      = data.azurerm_virtual_network.vnet_common.name
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

data "azurerm_nat_gateway" "nat_gateway" {
  name                = "io-p-natgw"
  resource_group_name = "io-p-rg-common"
}

resource "azurerm_subnet_nat_gateway_association" "fims_snet" {
  count          = var.fims_enabled ? 1 : 0
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway.id
  subnet_id      = module.fims_snet[0].id
}

module "appservice_fims" {
  count  = var.fims_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v4.1.15"

  # App service plan
  plan_type     = "internal"
  plan_name     = format("%s-plan-fims", local.project)
  plan_reserved = true # Mandatory for Linux plan
  plan_kind     = "Linux"
  plan_sku_tier = var.fims_plan_sku_tier
  plan_sku_size = var.fims_plan_sku_size

  # App service
  name                = format("%s-app-fims", local.project)
  resource_group_name = azurerm_resource_group.fims_rg[0].name
  location            = azurerm_resource_group.fims_rg[0].location

  always_on         = true
  linux_fx_version  = "NODE|18-lts"
  app_command_line  = local.fims.app_command_line
  health_check_path = "/api/info"

  app_settings = local.fims.app_settings_common

  allowed_subnets = [
    data.azurerm_subnet.appgateway_snet.id,
    data.azurerm_subnet.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  subnet_id        = module.fims_snet[0].id
  vnet_integration = true

  tags = var.tags
}

module "appservice_fims_slot_staging" {
  count  = var.fims_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot?ref=v4.1.15"

  # App service plan
  app_service_plan_id = module.appservice_fims[0].plan_id
  app_service_id      = module.appservice_fims[0].id
  app_service_name    = module.appservice_fims[0].name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.fims_rg[0].name
  location            = azurerm_resource_group.fims_rg[0].location

  always_on         = true
  linux_fx_version  = "NODE|18-lts"
  app_command_line  = local.fims.app_command_line
  health_check_path = "/api/info"

  app_settings = local.fims.app_settings_common

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
    data.azurerm_subnet.appgateway_snet.id,
    data.azurerm_subnet.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  subnet_id        = module.fims_snet[0].id
  vnet_integration = true

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "appservice_fims" {
  count               = var.fims_enabled ? 1 : 0
  name                = format("%s-autoscale", module.appservice_fims[0].name)
  resource_group_name = azurerm_resource_group.fims_rg[0].name
  location            = azurerm_resource_group.fims_rg[0].location
  target_resource_id  = module.appservice_fims[0].plan_id

  profile {
    name = "default"

    capacity {
      default = var.fims_autoscale_default
      minimum = var.fims_autoscale_minimum
      maximum = var.fims_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.appservice_fims[0].id
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
        metric_resource_id       = module.appservice_fims[0].plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 50
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
        metric_resource_id       = module.appservice_fims[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 1000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1H"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.appservice_fims[0].plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 10
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1H"
      }
    }
  }
}

resource "azurerm_monitor_metric_alert" "too_many_http_5xx" {
  count = var.fims_enabled ? 1 : 0

  enabled = false

  name                = "[IO-COMMONS | FIMS] Too many 5xx"
  resource_group_name = azurerm_resource_group.fims_rg[0].name
  scopes              = [data.azurerm_application_insights.application_insights.id]

  description   = "Whenever the total http server errors exceeds a dynamic threashold."
  severity      = 0
  window_size   = "PT5M"
  frequency     = "PT5M"
  auto_mitigate = false

  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftwebsites
  dynamic_criteria {
    metric_namespace         = "Microsoft.Web/sites"
    metric_name              = "Http5xx"
    aggregation              = "Total"
    operator                 = "GreaterThan"
    alert_sensitivity        = "Low"
    evaluation_total_count   = 4
    evaluation_failure_count = 4
    skip_metric_validation   = false

  }

  action {
    action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
    webhook_properties = null
  }

  tags = var.tags
}
