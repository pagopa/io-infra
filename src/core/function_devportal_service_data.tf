locals {
  function_devportalservicedata = {
    app_settings_commons = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      // connection to CosmosDB
      COSMOSDB_CONNECTIONSTRING          = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_api.endpoint, data.azurerm_cosmosdb_account.cosmos_api.primary_master_key),
      COSMOSDB_KEY                       = data.azurerm_cosmosdb_account.cosmos_api.primary_master_key
      COSMOSDB_NAME                      = "db",
      COSMOSDB_SERVICES_COLLECTION       = "services",
      COSMOSDB_SERVICES_LEASE_COLLECTION = "services-devportalservicedata-leases-001",
      COSMOSDB_URI                       = data.azurerm_cosmosdb_account.cosmos_api.endpoint

      // connection to APIM
      APIM_CLIENT_ID       = data.azurerm_key_vault_secret.devportal_service_principal_client_id.value
      APIM_RESOURCE_GROUP  = "io-p-rg-internal"
      APIM_SECRET          = data.azurerm_key_vault_secret.devportal_service_principal_secret.value
      APIM_SERVICE_NAME    = "io-p-apim-api"
      APIM_SUBSCRIPTION_ID = data.azurerm_subscription.current.subscription_id
      APIM_TENANT_ID       = data.azurerm_client_config.current.tenant_id

      // connection to PostgresSQL
      DB_HOST         = format("%s.postgres.database.azure.com", format("%s-%s-db-postgresql", local.project, "devportalservicedata"))
      DB_PORT         = 5432
      DB_IDLE_TIMEOUT = 30000 // milliseconds
      DB_NAME         = "db"
      DB_SCHEMA       = "DeveloperPortalServiceData"
      DB_TABLE        = "services"
      DB_USER         = format("%s", data.azurerm_key_vault_secret.devportalservicedata_db_server_adm_username.value)
      DB_PASSWORD     = data.azurerm_key_vault_secret.devportalservicedata_db_server_adm_password.value

      WEBSITE_VNET_ROUTE_ALL = "1"
      WEBSITE_DNS_SERVER     = "168.63.129.16"
    }

    // As we run this application under SelfCare IO logic subdomain,
    //  we share some resources
    app_context = {
      name             = "devportalsrvdata" # devportalservicedata would result in a name too long
      resource_group   = azurerm_resource_group.selfcare_be_rg
      app_service_plan = azurerm_app_service_plan.selfcare_be_common
      snet             = module.selfcare_be_common_snet
      vnet             = data.azurerm_virtual_network.vnet_common
    }

    db = {
      name = format("%s-%s-db-postgresql", local.project, "devportalservicedata")
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
module "function_devportalservicedata" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v2.9.1"

  name                = format("%s-%s-fn", local.project, local.function_devportalservicedata.app_context.name)
  location            = local.function_devportalservicedata.app_context.resource_group.location
  resource_group_name = local.function_devportalservicedata.app_context.resource_group.name
  app_service_plan_id = local.function_devportalservicedata.app_context.app_service_plan.id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core_windows_net.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core_windows_net.id],
    "containers"                 = [],
    "blobs_retention_days"       = 1,
    "queues"                     = []
  }

  runtime_version   = "~3"
  os_type           = "linux"
  health_check_path = "/api/v1/info"

  subnet_id   = local.function_devportalservicedata.app_context.snet.id
  allowed_ips = local.app_insights_ips_west_europe
  allowed_subnets = [
    module.selfcare_be_common_snet.id,
  ]

  app_settings = merge(local.function_devportalservicedata.app_settings_commons, {
    // those are slot configs
    "AzureWebJobs.OnServiceChange.Disabled"                 = "0"
    "AzureWebJobs.UpsertSubscriptionToMigrate.Disabled"     = "0"
    "AzureWebJobs.ChangeOneSubscriptionOwnership.Disabled"  = "0"
    "AzureWebJobs.ChangeAllSubscriptionsOwnership.Disabled" = "0"
  })

  tags = var.tags
}


module "function_devportalservicedata_staging_slot" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app_slot?ref=v2.9.1"

  name                = "staging"
  location            = local.function_devportalservicedata.app_context.resource_group.location
  resource_group_name = local.function_devportalservicedata.app_context.resource_group.name
  function_app_name   = module.function_devportalservicedata.name
  function_app_id     = module.function_devportalservicedata.id
  app_service_plan_id = local.function_devportalservicedata.app_context.app_service_plan.id

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  storage_account_name               = module.function_devportalservicedata.storage_account_name
  storage_account_access_key         = module.function_devportalservicedata.storage_account.primary_access_key
  internal_storage_connection_string = module.function_devportalservicedata.storage_account_internal_function.primary_connection_string

  runtime_version   = "~3"
  os_type           = "linux"
  health_check_path = "/api/v1/info"

  subnet_id = local.function_devportalservicedata.app_context.snet.id
  allowed_ips = concat(
    [],
  )
  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  app_settings = merge(local.function_devportalservicedata.app_settings_commons, {
    // disable listeners on staging slot
    "AzureWebJobs.OnServiceChange.Disabled"                 = "1"
    "AzureWebJobs.UpsertSubscriptionToMigrate.Disabled"     = "1"
    "AzureWebJobs.ChangeOneSubscriptionOwnership.Disabled"  = "1"
    "AzureWebJobs.ChangeAllSubscriptionsOwnership.Disabled" = "1"
  })

  tags = var.tags

  depends_on = [module.function_devportalservicedata]
}

#
# DB
#

// db admin user credentials
data "azurerm_key_vault_secret" "devportalservicedata_db_server_adm_username" {
  name         = "devportal-servicedata-DB-ADM-USERNAME"
  key_vault_id = data.azurerm_key_vault.common.id
}
data "azurerm_key_vault_secret" "devportalservicedata_db_server_adm_password" {
  name         = "devportal-servicedata-DB-ADM-PASSWORD"
  key_vault_id = data.azurerm_key_vault.common.id
}
// db applicative user credentials
data "azurerm_key_vault_secret" "devportalservicedata_db_server_fndevportalservicedata_password" {
  name         = "devportal-servicedata-FNDEVPORTALSERVICEDATA-PASSWORD"
  key_vault_id = data.azurerm_key_vault.common.id
}


module "devportalservicedata_db_server_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-snet", local.function_devportalservicedata.db.name)
  address_prefixes                               = var.cidr_subnet_devportalservicedata_db_server
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Sql"]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

module "devportalservicedata_db_server" {
  source = "git::https://github.com/pagopa/azurerm.git//postgres_flexible_server?ref=v2.19.1"

  name                = local.function_devportalservicedata.db.name
  location            = var.location
  resource_group_name = local.function_devportalservicedata.app_context.resource_group.name

  administrator_login    = data.azurerm_key_vault_secret.devportalservicedata_db_server_adm_username.value
  administrator_password = data.azurerm_key_vault_secret.devportalservicedata_db_server_adm_password.value

  sku_name                     = "GP_Standard_D2s_v3"
  db_version                   = 13
  geo_redundant_backup_enabled = true

  private_endpoint_enabled = true
  private_dns_zone_id      = azurerm_private_dns_zone.privatelink_postgres_database_azure_com.id
  delegated_subnet_id      = module.devportalservicedata_db_server_snet.id

  high_availability_enabled = false

  pgbouncer_enabled = true

  storage_mb = 32768 # 32GB

  alerts_enabled = true

  diagnostic_settings_enabled = false

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "devportalservicedata_db" {
  name       = "db"
  server_id  = module.devportalservicedata_db_server.id
  charset    = "UTF8"
  collation  = "en_US.utf8"
  depends_on = [module.devportalservicedata_db_server]
}
