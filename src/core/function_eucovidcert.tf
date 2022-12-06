#
# SECRETS
#

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_PROD_CLIENT_CERT" {
  name         = "eucovidcert-DGC-PROD-CLIENT-CERT"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_PROD_CLIENT_KEY" {
  name         = "eucovidcert-DGC-PROD-CLIENT-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_PROD_SERVER_CA" {
  name         = "eucovidcert-DGC-PROD-SERVER-CA"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_UAT_CLIENT_CERT" {
  name         = "eucovidcert-DGC-UAT-CLIENT-CERT"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_UAT_CLIENT_KEY" {
  name         = "eucovidcert-DGC-UAT-CLIENT-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_UAT_SERVER_CA" {
  name         = "eucovidcert-DGC-UAT-SERVER-CA"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_LOAD_TEST_CLIENT_KEY" {
  name         = "eucovidcert-DGC-LOAD-TEST-CLIENT-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_LOAD_TEST_CLIENT_CERT" {
  name         = "eucovidcert-DGC-LOAD-TEST-CLIENT-CERT"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_LOAD_TEST_SERVER_CA" {
  name         = "eucovidcert-DGC-LOAD-TEST-SERVER-CA"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_FNSERVICES_API_KEY" {
  name         = "fn3services-KEY-EUCOVIDCERT"
  key_vault_id = data.azurerm_key_vault.common.id
}

#
# RESOUCE GROUP
#
resource "azurerm_resource_group" "eucovidcert_rg" {
  name     = format("%s-rg-eucovidcert", local.project)
  location = var.location

  tags = var.tags
}

# 
# STORAGE
#
module "eucovidcert_storage_account" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v3.4.0"

  name                       = "${replace(local.project, "-", "")}steucovidcert"
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  access_tier                = "Hot"
  enable_versioning          = false
  account_replication_type   = "GRS"
  resource_group_name        = azurerm_resource_group.eucovidcert_rg.name
  location                   = azurerm_resource_group.eucovidcert_rg.location
  advanced_threat_protection = false
  allow_blob_public_access   = false

  tags = var.tags
}

#
# APP CONFIGURATION
#

locals {
  function_eucovidcert = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_VNET_ROUTE_ALL         = "1"
      WEBSITE_DNS_SERVER             = "168.63.129.16"
      FUNCTIONS_WORKER_PROCESS_COUNT = "4"
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      DGC_UAT_FISCAL_CODES = local.test_users_eu_covid_cert_flat
      # we need test_users_store_review_flat because app IO reviewers must read a valid certificate response
      LOAD_TEST_FISCAL_CODES = join(",", [
        local.test_users_store_review_flat,
        local.test_users_internal_load_flat
      ])

      DGC_UAT_URL               = "https://servizi-pnval.dgc.gov.it"
      DGC_LOAD_TEST_URL         = "https://io-p-fn3-mockdgc.azurewebsites.net"
      DGC_PROD_URL              = "https://servizi-pn.dgc.gov.it"
      DGC_PROD_CLIENT_CERT      = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_PROD_CLIENT_CERT.value)
      DGC_PROD_CLIENT_KEY       = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_PROD_CLIENT_KEY.value)
      DGC_PROD_SERVER_CA        = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_PROD_SERVER_CA.value)
      DGC_UAT_CLIENT_CERT       = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_UAT_CLIENT_CERT.value)
      DGC_UAT_CLIENT_KEY        = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_UAT_CLIENT_KEY.value)
      DGC_UAT_SERVER_CA         = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_UAT_SERVER_CA.value)
      DGC_LOAD_TEST_CLIENT_KEY  = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_LOAD_TEST_CLIENT_KEY.value)
      DGC_LOAD_TEST_CLIENT_CERT = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_LOAD_TEST_CLIENT_CERT.value)
      DGC_LOAD_TEST_SERVER_CA   = trimspace(data.azurerm_key_vault_secret.fn_eucovidcert_DGC_LOAD_TEST_SERVER_CA.value)

      // Events configs
      EventsQueueStorageConnection                    = module.eucovidcert_storage_account.primary_connection_string
      EUCOVIDCERT_PROFILE_CREATED_QUEUE_NAME          = "eucovidcert-profile-created"
      QueueStorageConnection                          = module.eucovidcert_storage_account.primary_connection_string
      EUCOVIDCERT_NOTIFY_NEW_PROFILE_QUEUE_NAME       = "notify-new-profile"
      TableStorageConnection                          = module.eucovidcert_storage_account.primary_connection_string
      EUCOVIDCERT_TRACE_NOTIFY_NEW_PROFILE_TABLE_NAME = "TraceNotifyNewProfile"

      FNSERVICES_API_URL = "https://io-p-fn3-services.azurewebsites.net/api/v1" # to be a reference once we migrate fn-services into this repository
      FNSERVICES_API_KEY = data.azurerm_key_vault_secret.fn_eucovidcert_FNSERVICES_API_KEY.value

    }
  }
}


# Subnet to host app function
module "function_eucovidcert_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-eucovidcert-snet", local.project)
  address_prefixes                               = var.cidr_subnet_eucovidcert
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

#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "function_eucovidcert" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v3.4.0"

  resource_group_name = azurerm_resource_group.eucovidcert_rg.name
  name                = format("%s-eucovidcert-fn", local.project)
  location            = var.location
  health_check_path   = "/api/v1/info"

  os_type          = "linux"
  linux_fx_version = "NODE|14"
  runtime_version  = "~4"

  always_on                                = "true"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.function_eucovidcert_kind
    sku_tier                     = var.function_eucovidcert_sku_tier
    sku_size                     = var.function_eucovidcert_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = merge(
    local.function_eucovidcert.app_settings_common,
    {
      "AzureWebJobs.NotifyNewProfileToDGC.Disabled" = "1"
      "AzureWebJobs.OnProfileCreatedEvent.Disabled" = "1"
    }
  )

  subnet_id = module.function_eucovidcert_snet.id

  allowed_subnets = [
    module.function_eucovidcert_snet.id,
    module.app_backendl1_snet.id,
    module.app_backendl2_snet.id,
    module.function_pblevtdispatcher_snetout.id,
    module.apim_snet.id,
  ]

  tags = var.tags
}

module "function_eucovidcert_staging_slot" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v3.4.0"

  name                = "staging"
  location            = var.location
  resource_group_name = azurerm_resource_group.eucovidcert_rg.name
  function_app_name   = module.function_eucovidcert.name
  function_app_id     = module.function_eucovidcert.id
  app_service_plan_id = module.function_eucovidcert.app_service_plan_id
  health_check_path   = "/api/v1/info"

  storage_account_name       = module.function_eucovidcert.storage_account.name
  storage_account_access_key = module.function_eucovidcert.storage_account.primary_access_key

  os_type                                  = "linux"
  linux_fx_version                         = "NODE|14"
  always_on                                = "true"
  runtime_version                          = "~4"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = merge(
    local.function_eucovidcert.app_settings_common,
    {
      "AzureWebJobs.NotifyNewProfileToDGC.Disabled" = "1"
      "AzureWebJobs.OnProfileCreatedEvent.Disabled" = "1"
    }
  )

  subnet_id = module.function_eucovidcert_snet.id

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
    module.function_eucovidcert_snet.id,
    module.app_backendl1_snet.id,
    module.app_backendl2_snet.id,
    module.function_pblevtdispatcher_snetout.id,
    module.apim_snet.id,
  ]

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "function_eucovidcert" {
  name                = format("%s-autoscale", module.function_eucovidcert.name)
  resource_group_name = azurerm_resource_group.eucovidcert_rg.name
  location            = var.location
  target_resource_id  = module.function_eucovidcert.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.function_eucovidcert_autoscale_default
      minimum = var.function_eucovidcert_autoscale_minimum
      maximum = var.function_eucovidcert_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.function_eucovidcert.id
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
        metric_resource_id       = module.function_eucovidcert.app_service_plan_id
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
        metric_resource_id       = module.function_eucovidcert.id
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
        metric_resource_id       = module.function_eucovidcert.app_service_plan_id
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

## Alerts

resource "azurerm_monitor_metric_alert" "function_eucovidcert_health_check" {

  name                = "${module.function_eucovidcert.name}-health-check-failed"
  resource_group_name = azurerm_resource_group.eucovidcert_rg.name
  scopes              = [module.function_eucovidcert.id]
  description         = "${module.function_eucovidcert.name} health check failed"
  severity            = 1
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 50
  }

  action {
    action_group_id = azurerm_monitor_action_group.email.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack.id
  }
}
