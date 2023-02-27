locals {
  function_lollipop = {
    app_settings = {
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      COSMOSDB_NAME                = "db"
      COSMOSDB_URI                 = data.azurerm_cosmosdb_account.cosmos_citizen_auth.endpoint
      COSMOSDB_KEY                 = data.azurerm_cosmosdb_account.cosmos_citizen_auth.primary_key
      COSMOS_API_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_citizen_auth.endpoint, data.azurerm_cosmosdb_account.cosmos_citizen_auth.primary_key)

      LOLLIPOP_ASSERTION_STORAGE_CONNECTION_STRING = data.azurerm_storage_account.lollipop_assertion_storage.primary_connection_string
      LOLLIPOP_ASSERTION_REVOKE_QUEUE              = "pubkeys-revoke"


      // ------------
      // JWT Config
      // ------------
      ISSUER = local.lollipop_jwt_host

      PRIMARY_PRIVATE_KEY = data.azurerm_key_vault_certificate_data.lollipop_certificate_v1.key
      PRIMARY_PUBLIC_KEY  = data.azurerm_key_vault_certificate_data.lollipop_certificate_v1.pem

      // Use it during rotation period. See https://pagopa.atlassian.net/wiki/spaces/IC/pages/645136398/LolliPoP+Procedura+di+rotazione+dei+certificati
      //SECONDARY_PUBLIC_KEY = 

    }
  }
}

resource "azurerm_resource_group" "lollipop_rg" {
  count    = var.lollipop_enabled ? 1 : 0
  name     = format("%s-lollipop-rg", local.common_project)
  location = var.location

  tags = var.tags
}

# Subnet to host admin function
module "lollipop_snet" {
  count                                     = var.lollipop_enabled ? 1 : 0
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v4.1.15"
  name                                      = format("%s-lollipop-snet", local.common_project)
  address_prefixes                          = var.cidr_subnet_fnlollipop
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

module "function_lollipop" {
  count  = var.lollipop_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v5.2.0"

  resource_group_name = azurerm_resource_group.lollipop_rg[0].name
  name                = format("%s-lollipop-fn", local.common_project)
  location            = var.location
  domain              = "IO-COMMONS"
  health_check_path   = "/info"

  node_version    = "18"
  runtime_version = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_lollipop_kind
    sku_size                     = var.function_lollipop_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = merge(
    local.function_lollipop.app_settings,
    { "AzureWebJobs.HandlePubKeyRevoke.Disabled" = "0" },
  )

  sticky_settings = ["AzureWebJobs.HandlePubKeyRevoke.Disabled"]

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues"                     = [],
    "containers"                 = [],
    "blobs_retention_days"       = 0,
  }

  subnet_id = module.lollipop_snet[0].id

  allowed_subnets = [
    module.lollipop_snet[0].id,
    data.azurerm_subnet.apim_snet.id,
    data.azurerm_subnet.app_backend_l1_snet.id,
    data.azurerm_subnet.app_backend_l2_snet.id,
  ]

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}

module "function_lollipop_staging_slot" {
  count  = var.lollipop_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v5.2.0"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.lollipop_rg[0].name
  # function_app_name   = module.function_lollipop[0].name
  function_app_id     = module.function_lollipop[0].id
  app_service_plan_id = module.function_lollipop[0].app_service_plan_id
  health_check_path   = "/info"

  storage_account_name               = module.function_lollipop[0].storage_account.name
  storage_account_access_key         = module.function_lollipop[0].storage_account.primary_access_key
  internal_storage_connection_string = module.function_lollipop[0].storage_account_internal_function.primary_connection_string

  node_version                             = "18"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_lollipop.app_settings,
    { "AzureWebJobs.HandlePubKeyRevoke.Disabled" = "1" },
  )

  subnet_id = module.lollipop_snet[0].id

  allowed_subnets = [
    module.lollipop_snet[0].id,
    data.azurerm_subnet.azdoa_snet[0].id,
    data.azurerm_subnet.apim_snet.id,
    data.azurerm_subnet.app_backend_l1_snet.id,
    data.azurerm_subnet.app_backend_l2_snet.id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_lollipop" {
  count               = var.lollipop_enabled ? 1 : 0
  name                = format("%s-autoscale", module.function_lollipop[0].name)
  resource_group_name = azurerm_resource_group.lollipop_rg[0].name
  location            = var.location
  target_resource_id  = module.function_lollipop[0].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_lollipop_autoscale_default
      minimum = var.function_lollipop_autoscale_minimum
      maximum = var.function_lollipop_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_lollipop[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3000
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
        metric_resource_id       = module.function_lollipop[0].app_service_plan_id
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
        metric_resource_id       = module.function_lollipop[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2000
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
        metric_resource_id       = module.function_lollipop[0].app_service_plan_id
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