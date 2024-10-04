data "azurerm_nat_gateway" "nat_gateway" {
  name                = "${local.product}-natgw"
  resource_group_name = local.vnet_common_resource_group_name
}

resource "azurerm_resource_group" "app_messages_rg_xl" {
  name     = format("%s-weu-com-rg-01", local.product)
  location = var.location

  tags = var.tags
}

module "app_messages_snet_xl" {
  count  = var.app_messages_count
  source = "github.com/pagopa/terraform-azurerm-v3//subnet?ref=v8.27.0"

  name                                      = format("%s-weu-com-citizen-func-snet-%d", local.product, count.index + 1)
  address_prefixes                          = [var.cidr_subnet_appmessages_xl[count.index]]
  resource_group_name                       = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet_common.name
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.AzureCosmosDB",
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

module "app_messages_function_xl" {
  count  = var.app_messages_count
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v8.27.0"

  resource_group_name = azurerm_resource_group.app_messages_rg_xl.name
  name                = format("%s-weu-com-citizen-func-0%d", local.product, count.index + 1)
  domain              = "MESSAGES"
  location            = azurerm_resource_group.app_messages_rg_xl.location

  health_check_path            = "/api/v1/info"
  health_check_maxpingfailures = 2

  runtime_version                          = "~4"
  node_version                             = "18"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = "Linux"
    sku_tier                     = "PremiumV3"
    sku_size                     = "P2mv3"
    maximum_elastic_worker_count = 0
    worker_count                 = null
    zone_balancing_enabled       = false
  }

  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "GZRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    use_legacy_defender_version       = true
    public_network_access_enabled     = false
  }

  app_settings = merge(
    local.function_app_messages.app_settings_common,
    {
      FUNCTIONS_WORKER_PROCESS_COUNT    = 8,
      WEBSITE_SWAP_WARMUP_PING_PATH     = "/api/v1/info",
      WEBSITE_SWAP_WARMUP_PING_STATUSES = "200"
    }
  )

  subnet_id = module.app_messages_snet_xl[count.index].id

  allowed_subnets = [
    module.app_messages_snet_xl[count.index].id,
    data.azurerm_subnet.app_backendl1_snet.id,
    data.azurerm_subnet.app_backendl2_snet.id,
    data.azurerm_subnet.app_backendl3_snet.id,
    data.azurerm_subnet.apim_snet.id,
  ]

  allowed_ips = concat(
    [],
    local.app_insights_ips_west_europe,
  )

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.io_com_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}

module "app_messages_function_staging_slot_xl" {
  count  = var.app_messages_count
  source = "github.com/pagopa/terraform-azurerm-v3//function_app_slot?ref=v8.27.0"

  name                = "staging"
  location            = azurerm_resource_group.app_messages_rg_xl.location
  resource_group_name = azurerm_resource_group.app_messages_rg_xl.name
  function_app_id     = module.app_messages_function_xl[count.index].id
  app_service_plan_id = module.app_messages_function_xl[count.index].app_service_plan_id

  health_check_path            = "/api/v1/info"
  health_check_maxpingfailures = 2

  storage_account_name       = module.app_messages_function_xl[count.index].storage_account.name
  storage_account_access_key = module.app_messages_function_xl[count.index].storage_account.primary_access_key

  os_type                                  = "linux"
  runtime_version                          = "~4"
  node_version                             = "18"
  always_on                                = true
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_app_messages.app_settings_common,
    {
      WEBSITE_SWAP_WARMUP_PING_PATH     = "/api/v1/info",
      WEBSITE_SWAP_WARMUP_PING_STATUSES = "200"
    }
  )

  subnet_id = module.app_messages_snet_xl[count.index].id

  allowed_subnets = [
    module.app_messages_snet_xl[count.index].id,
    data.azurerm_subnet.app_backendl1_snet.id,
    data.azurerm_subnet.app_backendl2_snet.id,
    data.azurerm_subnet.app_backendl3_snet.id,
    data.azurerm_subnet.azdoa_snet.id,
    data.azurerm_subnet.github_snet.id,
  ]

  allowed_ips = concat(
    [],
  )

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "app_messages_function_xl" {
  count               = var.app_messages_count
  name                = replace(module.app_messages_function_xl[count.index].name, "func", "as")
  resource_group_name = azurerm_resource_group.app_messages_rg_xl.name
  location            = azurerm_resource_group.app_messages_rg_xl.location
  target_resource_id  = module.app_messages_function_xl[count.index].app_service_plan_id

  profile {
    name = "evening"

    capacity {
      default = 10
      minimum = 5
      maximum = 20
    }

    recurrence {
      timezone = "W. Europe Standard Time"
      hours    = [19]
      minutes  = [30]
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

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_messages_function_xl[count.index].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 2500
        divide_by_instance_count = true
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
        metric_resource_id       = module.app_messages_function_xl[count.index].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 40
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "3"
        cooldown  = "PT2M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_messages_function_xl[count.index].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 200
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.app_messages_function_xl[count.index].app_service_plan_id
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
        cooldown  = "PT2M"
      }
    }
  }

  profile {
    name = "night"

    capacity {
      default = 10
      minimum = 2
      maximum = 15
    }

    recurrence {
      timezone = "W. Europe Standard Time"
      hours    = [23]
      minutes  = [0]
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

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_messages_function_xl[count.index].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 3000
        divide_by_instance_count = true
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
        metric_resource_id       = module.app_messages_function_xl[count.index].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 50
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "3"
        cooldown  = "PT2M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_messages_function_xl[count.index].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 400
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.app_messages_function_xl[count.index].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 20
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT2M"
      }
    }
  }

  profile {
    name = "{\"name\":\"default\",\"for\":\"evening\"}"

    recurrence {
      timezone = "W. Europe Standard Time"
      hours    = [22]
      minutes  = [59]
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

    capacity {
      default = 10
      minimum = 3
      maximum = 30
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_messages_function_xl[count.index].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 3000
        divide_by_instance_count = true
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
        metric_resource_id       = module.app_messages_function_xl[count.index].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 40
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "3"
        cooldown  = "PT2M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_messages_function_xl[count.index].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 300
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.app_messages_function_xl[count.index].app_service_plan_id
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
        cooldown  = "PT2M"
      }
    }
  }

  profile {
    name = "{\"name\":\"default\",\"for\":\"night\"}"

    capacity {
      default = 10
      minimum = 3
      maximum = 30
    }

    recurrence {
      timezone = "W. Europe Standard Time"
      hours    = [5]
      minutes  = [0]
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

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_messages_function_xl[count.index].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 3000
        divide_by_instance_count = true
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
        metric_resource_id       = module.app_messages_function_xl[count.index].app_service_plan_id
        metric_namespace         = "microsoft.web/serverfarms"
        time_grain               = "PT1M"
        statistic                = "Max"
        time_window              = "PT1M"
        time_aggregation         = "Maximum"
        operator                 = "GreaterThan"
        threshold                = 40
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "3"
        cooldown  = "PT2M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.app_messages_function_xl[count.index].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 300
        divide_by_instance_count = true
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "CpuPercentage"
        metric_resource_id       = module.app_messages_function_xl[count.index].app_service_plan_id
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
        cooldown  = "PT2M"
      }
    }
  }

  tags = var.tags
}

resource "azurerm_subnet_nat_gateway_association" "net_gateway_association_subnet_citizen_func_xl" {
  count          = var.app_messages_count
  nat_gateway_id = data.azurerm_nat_gateway.nat_gateway.id
  subnet_id      = module.app_messages_snet_xl[count.index].id
}

resource "azurerm_private_endpoint" "function_sites_xl" {
  count               = var.app_messages_count
  name                = format("%s-weu-com-citizen-func-pep-0%d", local.product, count.index + 1)
  location            = azurerm_resource_group.app_messages_rg_xl.location
  resource_group_name = azurerm_resource_group.app_messages_rg_xl.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-weu-com-citizen-func-pep-0%d", local.product, count.index + 1)
    private_connection_resource_id = module.app_messages_function_xl.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.function_app.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_function_sites_xl" {
  count  = var.app_messages_count
  name                = format("%s-weu-com-citizen-func-staging-pep-0%d", local.product, count.index + 1)
  location            = azurerm_resource_group.app_messages_rg_xl.location
  resource_group_name = azurerm_resource_group.app_messages_rg_xl.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-weu-com-citizen-func-staging-pep-0%d", local.product, count.index + 1)
    private_connection_resource_id = module.app_messages_function_xl.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.app_messages_function_staging_slot_xl.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.function_app.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "function_sites_xl" {
  count               = var.app_messages_count
  name                = format("%s-weu-com-citizen-func-pep-0%d", local.product, count.index + 1)
  location            = azurerm_resource_group.app_messages_rg_xl.location
  resource_group_name = azurerm_resource_group.app_messages_rg_xl.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-weu-com-citizen-func-pep-0%d", local.product, count.index + 1)
    private_connection_resource_id = module.app_messages_function_xl.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.function_app.id]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "staging_function_sites_xl" {
  count               = var.app_messages_count
  name                = format("%s-weu-com-citizen-func-staging-pep-0%d", local.product, count.index + 1)
  location            = azurerm_resource_group.app_messages_rg_xl.location
  resource_group_name = azurerm_resource_group.app_messages_rg_xl.name
  subnet_id           = data.azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = format("%s-weu-com-citizen-func-staging-pep-0%d", local.product, count.index + 1)
    private_connection_resource_id = module.app_messages_function_xl.id
    is_manual_connection           = false
    subresource_names              = ["sites-${module.app_messages_function_staging_slot_xl.name}"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.function_app.id]
  }

  tags = var.tags
}