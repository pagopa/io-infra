locals {
  function_subscriptionmigrations = {
    app_settings_commons = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.application_insights.instrumentation_key

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      // connection to CosmosDB
      COSMOSDB_CONNECTIONSTRING          = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_api.endpoint, data.azurerm_cosmosdb_account.cosmos_api.primary_key),
      COSMOSDB_KEY                       = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOSDB_NAME                      = "db",
      COSMOSDB_SERVICES_COLLECTION       = "services",
      COSMOSDB_SERVICES_LEASE_COLLECTION = "services-subsmigrations-leases-002",
      COSMOSDB_URI                       = data.azurerm_cosmosdb_account.cosmos_api.endpoint

      // connection to APIM
      APIM_CLIENT_ID       = data.azurerm_key_vault_secret.selfcare_devportal_service_principal_client_id.value
      APIM_RESOURCE_GROUP  = "io-p-rg-internal"
      APIM_SECRET          = data.azurerm_key_vault_secret.selfcare_devportal_service_principal_secret.value
      APIM_SERVICE_NAME    = "io-p-apim-api"
      APIM_SUBSCRIPTION_ID = data.azurerm_subscription.current.subscription_id
      APIM_TENANT_ID       = data.azurerm_client_config.current.tenant_id

      // connection to PostgresSQL
      DB_HOST         = format("%s.postgres.database.azure.com", format("%s-%s-db-postgresql", local.project, "subsmigrations"))
      DB_PORT         = 5432
      DB_IDLE_TIMEOUT = 30000 // milliseconds
      DB_NAME         = "db"
      DB_SCHEMA       = "SelfcareIOSubscriptionMigrations"
      DB_TABLE        = "migrations"
      DB_USER         = format("%s@%s", data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_username.value, format("%s.postgres.database.azure.com", format("%s-%s-db-postgresql", local.project, "subsmigrations")))
      DB_PASSWORD     = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_password.value

      // job queues
      QUEUE_ADD_SERVICE_TO_MIGRATIONS    = "add-service-jobs"               // when a service change is accepted to be processed into migration log
      QUEUE_ALL_SUBSCRIPTIONS_TO_MIGRATE = "migrate-all-subscriptions-jobs" // when a migration is requested for all subscriptions
      QUEUE_SUBSCRIPTION_TO_MIGRATE      = "migrate-one-subscription-jobs"  // when a subscription is requested to migrate its ownership

      WEBSITE_VNET_ROUTE_ALL = "1"
      WEBSITE_DNS_SERVER     = "168.63.129.16"
    }

    // As we run this application under SelfCare IO logic subdomain,
    //  we share some resources
    app_context = {
      name             = "subsmigrations"
      resource_group   = azurerm_resource_group.selfcare_be_rg
      app_service_plan = azurerm_app_service_plan.selfcare_be_common
      snet             = module.selfcare_be_common_snet
      vnet             = data.azurerm_virtual_network.vnet_common
    }

    db = {
      name = format("%s-%s-db-postgresql", local.project, "subsmigrations")
    }

    metric_alerts = {
      db = {
        cpu = {
          aggregation = "Average"
          metric_name = "cpu_percent"
          operator    = "GreaterThan"
          threshold   = 70
          frequency   = "PT1M"
          window_size = "PT5M"
          dimension   = []
        }
        memory = {
          aggregation = "Average"
          metric_name = "memory_percent"
          operator    = "GreaterThan"
          threshold   = 75
          frequency   = "PT1M"
          window_size = "PT5M"
          dimension   = []
        }
        io = {
          aggregation = "Average"
          metric_name = "io_consumption_percent"
          operator    = "GreaterThan"
          threshold   = 55
          frequency   = "PT1M"
          window_size = "PT5M"
          dimension   = []
        }
        # https://docs.microsoft.com/it-it/azure/postgresql/concepts-limits
        # GP_Gen5_2 -| 145 / 100 * 80 = 116
        # GP_Gen5_32 -| 1495 / 100 * 80 = 1196
        max_active_connections = {
          aggregation = "Average"
          metric_name = "active_connections"
          operator    = "GreaterThan"
          threshold   = 1196
          frequency   = "PT5M"
          window_size = "PT5M"
          dimension   = []
        }
        min_active_connections = {
          aggregation = "Average"
          metric_name = "active_connections"
          operator    = "LessThanOrEqual"
          threshold   = 0
          frequency   = "PT5M"
          window_size = "PT15M"
          dimension   = []
        }
        failed_connections = {
          aggregation = "Total"
          metric_name = "connections_failed"
          operator    = "GreaterThan"
          threshold   = 10
          frequency   = "PT5M"
          window_size = "PT15M"
          dimension   = []
        }
        replica_lag = {
          aggregation = "Average"
          metric_name = "pg_replica_log_delay_in_seconds"
          operator    = "GreaterThan"
          threshold   = 60
          frequency   = "PT1M"
          window_size = "PT5M"
          dimension   = []
        }
      }
    }
  }
}

#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "function_subscriptionmigrations" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v4.1.15"

  name                = format("%s-%s-fn", local.project, local.function_subscriptionmigrations.app_context.name)
  location            = local.function_subscriptionmigrations.app_context.resource_group.location
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  app_service_plan_id = local.function_subscriptionmigrations.app_context.app_service_plan.id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = module.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "queues" = [
      local.function_subscriptionmigrations.app_settings_commons.QUEUE_ADD_SERVICE_TO_MIGRATIONS,
      local.function_subscriptionmigrations.app_settings_commons.QUEUE_ALL_SUBSCRIPTIONS_TO_MIGRATE,
      local.function_subscriptionmigrations.app_settings_commons.QUEUE_SUBSCRIPTION_TO_MIGRATE,
    ],
    "containers"           = [],
    "blobs_retention_days" = 1,
  }

  runtime_version   = "~3"
  os_type           = "linux"
  health_check_path = "/api/v1/info"
  linux_fx_version  = "NODE|14"

  subnet_id   = local.function_subscriptionmigrations.app_context.snet.id
  allowed_ips = local.app_insights_ips_west_europe
  allowed_subnets = [
    module.selfcare_be_common_snet.id,
  ]

  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "LRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }

  app_settings = merge(local.function_subscriptionmigrations.app_settings_commons, {
    // those are slot configs
    "AzureWebJobs.OnServiceChange.Disabled"                 = "0"
    "AzureWebJobs.UpsertSubscriptionToMigrate.Disabled"     = "0"
    "AzureWebJobs.ChangeOneSubscriptionOwnership.Disabled"  = "0"
    "AzureWebJobs.ChangeAllSubscriptionsOwnership.Disabled" = "0"
  })

  tags = var.tags
}


module "function_subscriptionmigrations_staging_slot" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v4.1.15"

  name                = "staging"
  location            = local.function_subscriptionmigrations.app_context.resource_group.location
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  function_app_name   = module.function_subscriptionmigrations.name
  function_app_id     = module.function_subscriptionmigrations.id
  app_service_plan_id = local.function_subscriptionmigrations.app_context.app_service_plan.id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  storage_account_name               = module.function_subscriptionmigrations.storage_account_name
  storage_account_access_key         = module.function_subscriptionmigrations.storage_account.primary_access_key
  internal_storage_connection_string = module.function_subscriptionmigrations.storage_account_internal_function.primary_connection_string

  runtime_version   = "~3"
  os_type           = "linux"
  health_check_path = "/api/v1/info"
  linux_fx_version  = "NODE|14"
  always_on         = "true"

  subnet_id = local.function_subscriptionmigrations.app_context.snet.id
  allowed_ips = concat(
    [],
  )
  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  app_settings = merge(local.function_subscriptionmigrations.app_settings_commons, {
    // disable listeners on staging slot
    "AzureWebJobs.OnServiceChange.Disabled"                 = "1"
    "AzureWebJobs.UpsertSubscriptionToMigrate.Disabled"     = "1"
    "AzureWebJobs.ChangeOneSubscriptionOwnership.Disabled"  = "1"
    "AzureWebJobs.ChangeAllSubscriptionsOwnership.Disabled" = "1"
  })

  tags = var.tags
}

#
# DB
#

// db admin user credentials
data "azurerm_key_vault_secret" "subscriptionmigrations_db_server_adm_username" {
  name         = "selfcare-subsmigrations-DB-ADM-USERNAME"
  key_vault_id = module.key_vault_common.id
}
data "azurerm_key_vault_secret" "subscriptionmigrations_db_server_adm_password" {
  name         = "selfcare-subsmigrations-DB-ADM-PASSWORD"
  key_vault_id = module.key_vault_common.id
}
// db applicative user credentials
data "azurerm_key_vault_secret" "subscriptionmigrations_db_server_fnsubsmigrations_password" {
  name         = "selfcare-subsmigrations-FNSUBSMIGRATIONS-PASSWORD"
  key_vault_id = module.key_vault_common.id
}


module "subscriptionmigrations_db_server" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//postgresql_server?ref=v4.1.15"

  name                = local.function_subscriptionmigrations.db.name
  location            = var.location
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name

  administrator_login          = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_username.value
  administrator_login_password = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_password.value

  sku_name                     = "GP_Gen5_2"
  db_version                   = 11
  geo_redundant_backup_enabled = false

  public_network_access_enabled = false
  private_endpoint = {
    enabled              = true
    virtual_network_id   = local.function_subscriptionmigrations.app_context.vnet.id
    subnet_id            = module.private_endpoints_subnet.id
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_postgres_database_azure_com.id]
  }

  alerts_enabled                = true
  monitor_metric_alert_criteria = local.function_subscriptionmigrations.metric_alerts.db
  action = [
    {
      action_group_id    = azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = azurerm_monitor_action_group.slack.id
      webhook_properties = null
    }
  ]

  lock_enable = var.lock_enable

  tags = var.tags
}

resource "azurerm_postgresql_database" "selfcare_subscriptionmigrations_db" {
  name                = "db"
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  server_name         = module.subscriptionmigrations_db_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
