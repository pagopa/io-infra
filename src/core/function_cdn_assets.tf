locals {
  function_cdn_assets = {
    app_settings = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_VNET_ROUTE_ALL         = "1"
      WEBSITE_DNS_SERVER             = "168.63.129.16"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"
    }
  }
}

# Subnet to host fn cdn assets function
module "function_cdn_assets_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-cdn-assets-fn-snet", local.project)
  address_prefixes                               = var.cidr_subnet_fncdnassets
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "function_cdn_assets" {
  # source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.9.1"
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=upgrade-fn-modules"

  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  name                = "${local.project}-cdn-assets-fn"
  location            = var.location
  health_check_path   = "info"

  os_type                                  = "linux"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_cdn_assets_kind
    sku_tier                     = var.function_cdn_assets_sku_tier
    sku_size                     = var.function_cdn_assets_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = local.function_cdn_assets.app_settings

  subnet_id = module.function_cdn_assets_snet.id

  tags = var.tags
}

module "function_cdn_assets_staging_slot" {
  count = var.function_cdn_assets_sku_tier == "PremiumV3" ? 1 : 0
  # source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v2.9.1"
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=upgrade-fn-modules"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.assets_cdn_rg.name
  function_app_name   = module.function_cdn_assets.name
  function_app_id     = module.function_cdn_assets.id
  app_service_plan_id = module.function_cdn_assets.app_service_plan_id
  health_check_path   = "info"

  storage_account_name       = module.function_cdn_assets.storage_account.name
  storage_account_access_key = module.function_cdn_assets.storage_account.primary_access_key

  os_type                                  = "linux"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = local.function_cdn_assets.app_settings

  subnet_id = module.function_cdn_assets_snet.id

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_cdn_assets" {
  count               = var.function_cdn_assets_sku_tier == "PremiumV3" ? 1 : 0
  name                = format("%s-autoscale", module.function_cdn_assets.name)
  resource_group_name = azurerm_resource_group.backend_messages_rg.name
  location            = var.location
  target_resource_id  = module.function_cdn_assets.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_cdn_assets_autoscale_default
      minimum = var.function_cdn_assets_autoscale_minimum
      maximum = var.function_cdn_assets_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_cdn_assets.id
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
        metric_resource_id       = module.function_cdn_assets.app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 60
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
        metric_resource_id       = module.function_cdn_assets.id
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
        metric_resource_id       = module.function_cdn_assets.app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 30
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
