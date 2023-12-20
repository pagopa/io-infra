locals {
  function_elt = {
    app_settings = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
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
      COSMOSDB_URI                 = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY                 = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOS_API_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_api.endpoint, data.azurerm_cosmosdb_account.cosmos_api.primary_key)

      TARGETKAFKA_clientId            = "IO_FUNCTIONS_ELT"
      TARGETKAFKA_brokers             = local.event_hub.connection
      TARGETKAFKA_ssl                 = "true"
      TARGETKAFKA_sasl_mechanism      = "plain"
      TARGETKAFKA_sasl_username       = "$ConnectionString"
      TARGETKAFKA_sasl_password       = module.event_hub.keys["io-cosmosdb-services.io-fn-elt"].primary_connection_string
      TARGETKAFKA_maxInFlightRequests = "1"
      TARGETKAFKA_idempotent          = "true"
      TARGETKAFKA_transactionalId     = "IO_ELT"
      TARGETKAFKA_topic               = "io-cosmosdb-services"

      SERVICES_TOPIC_NAME              = "io-cosmosdb-services"
      SERVICES_TOPIC_CONNECTION_STRING = module.event_hub.keys["io-cosmosdb-services.io-fn-elt"].primary_connection_string
      SERVICES_LEASES_PREFIX           = "services-001"

      MESSAGES_TOPIC_NAME              = "pdnd-io-cosmosdb-messages"
      MESSAGES_TOPIC_CONNECTION_STRING = module.event_hub.keys["pdnd-io-cosmosdb-messages.io-fn-elt"].primary_connection_string
      MESSAGES_LEASES_PREFIX           = "messages-001"

      MESSAGE_STATUS_TOPIC_NAME              = "pdnd-io-cosmosdb-message-status"
      MESSAGE_STATUS_TOPIC_CONNECTION_STRING = module.event_hub.keys["pdnd-io-cosmosdb-message-status.io-fn-elt"].primary_connection_string
      MESSAGE_STATUS_LEASES_PREFIX           = "message-status-001"

      NOTIFICATION_STATUS_TOPIC_NAME              = "pdnd-io-cosmosdb-notification-status"
      NOTIFICATION_STATUS_TOPIC_CONNECTION_STRING = module.event_hub.keys["pdnd-io-cosmosdb-notification-status.io-fn-elt"].primary_connection_string
      NOTIFICATION_STATUS_LEASES_PREFIX           = "notification-status-001"


      ERROR_STORAGE_ACCOUNT                   = module.storage_account_elt.name
      ERROR_STORAGE_KEY                       = module.storage_account_elt.primary_access_key
      ERROR_STORAGE_TABLE                     = azurerm_storage_table.fnelterrors.name
      ERROR_STORAGE_TABLE_MESSAGES            = azurerm_storage_table.fnelterrors_messages.name
      ERROR_STORAGE_TABLE_MESSAGE_STATUS      = azurerm_storage_table.fnelterrors_message_status.name
      ERROR_STORAGE_TABLE_NOTIFICATION_STATUS = azurerm_storage_table.fnelterrors_notification_status.name

      COMMAND_STORAGE                = module.storage_account_elt.primary_connection_string
      COMMAND_STORAGE_TABLE          = azurerm_storage_table.fneltcommands.name
      IMPORT_TOPIC_NAME              = "import-command"
      IMPORT_TOPIC_CONNECTION_STRING = module.event_hub.keys["import-command.io-fn-elt"].primary_connection_string

      PROFILE_TOPIC_NAME              = "io-cosmosdb-profiles"
      PROFILE_TOPIC_CONNECTION_STRING = module.event_hub.keys["io-cosmosdb-profiles.io-fn-elt"].primary_connection_string

      COSMOSDB_REPLICA_NAME     = "db"
      COSMOSDB_REPLICA_URI      = replace(data.azurerm_cosmosdb_account.cosmos_api.endpoint, "io-p-cosmos-api", "io-p-cosmos-api-northeurope")
      COSMOSDB_REPLICA_KEY      = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOSDB_REPLICA_LOCATION = "North Europe"

      MESSAGE_EXPORTS_COMMAND_TABLE       = azurerm_storage_table.fneltexports.name
      MESSAGE_EXPORT_STEP_1_CONTAINER     = azurerm_storage_container.container_messages_report_step1.name
      MESSAGE_EXPORT_STEP_FINAL_CONTAINER = azurerm_storage_container.container_messages_report_step_final.name

      COSMOS_CHUNK_SIZE            = "1000"
      COSMOS_DEGREE_OF_PARALLELISM = "2"
      MESSAGE_CONTENT_CHUNK_SIZE   = "200"

      SERVICEID_EXCLUSION_LIST = data.azurerm_key_vault_secret.services_exclusion_list.value

      PN_SERVICE_ID = var.pn_service_id

      #iopstapi connection string
      MessageContentPrimaryStorageConnection = module.storage_api.primary_connection_string
      #iopstapireplica connection string
      MessageContentStorageConnection  = module.storage_api_replica.primary_connection_string
      ServiceInfoBlobStorageConnection = module.assets_cdn.primary_connection_string

      MESSAGES_FAILURE_QUEUE_NAME       = "pdnd-io-cosmosdb-messages-failure"
      MESSAGE_STATUS_FAILURE_QUEUE_NAME = "pdnd-io-cosmosdb-message-status-failure"
      SERVICES_FAILURE_QUEUE_NAME       = "pdnd-io-cosmosdb-services-failure"

      INTERNAL_TEST_FISCAL_CODES = local.test_users
    }
  }
}

resource "azurerm_resource_group" "elt_rg" {
  name     = format("%s-elt-rg", local.project)
  location = var.location

  tags = var.tags
}

module "function_elt_snetout" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.34.3"
  name                                      = "fn3eltout"
  address_prefixes                          = var.cidr_subnet_fnelt
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.EventHub",
    "Microsoft.Storage",
    "Microsoft.AzureCosmosDB",
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
module "function_elt" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v7.34.3"

  resource_group_name                      = azurerm_resource_group.elt_rg.name
  name                                     = "${local.project}-fn-elt"
  domain                                   = "IO-COMMONS"
  storage_account_name                     = "${replace(local.project, "-", "")}stfnelt"
  app_service_plan_name                    = "${local.project}-plan-fnelt"
  location                                 = var.location
  health_check_path                        = "/api/v1/info"
  subnet_id                                = module.function_elt_snetout.id
  runtime_version                          = "~4"
  node_version                             = "18"
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = "elastic"
    sku_tier                     = "ElasticPremium"
    sku_size                     = "EP1"
    maximum_elastic_worker_count = 1
    worker_count                 = null
    zone_balancing_enabled       = null
  }

  app_settings = merge(
    local.function_elt.app_settings, {
      "AzureWebJobs.CosmosApiServicesChangeFeed.Disabled"                             = "1"
      "AzureWebJobs.CosmosApiMessageStatusChangeFeed.Disabled"                        = "1"
      "AzureWebJobs.CosmosApiMessagesChangeFeed.Disabled"                             = "1"
      "AzureWebJobs.AnalyticsMessagesChangeFeedInboundProcessorAdapter.Disabled"      = "0"
      "AzureWebJobs.AnalyticsMessagesStorageQueueInboundProcessorAdapter.Disabled"    = "0"
      "AzureWebJobs.AnalyticsMessageStatusChangeFeedInboundProcessorAdapter.Disabled" = "0"
      "AzureWebJobs.AnalyticsMessageStatusStorageQueueInbloundAdapter.Disabled"       = "0"
      "AzureWebJobs.AnalyticsServiceChangeFeedInboundProcessorAdapter.Disabled"       = "0"
      "AzureWebJobs.AnalyticsServiceStorageQueueInboundProcessorAdapter.Disabled"     = "0"
    }
  )

  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = "GRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = module.private_endpoints_subnet.id,
    "private_dns_zone_blob_ids"  = [azurerm_private_dns_zone.privatelink_blob_core.id],
    "private_dns_zone_queue_ids" = [azurerm_private_dns_zone.privatelink_queue_core.id],
    "private_dns_zone_table_ids" = [azurerm_private_dns_zone.privatelink_table_core.id],
    "queues" = [
      local.function_elt.app_settings.MESSAGES_FAILURE_QUEUE_NAME,
      "${local.function_elt.app_settings.MESSAGES_FAILURE_QUEUE_NAME}-poison",
      local.function_elt.app_settings.MESSAGE_STATUS_FAILURE_QUEUE_NAME,
      "${local.function_elt.app_settings.MESSAGE_STATUS_FAILURE_QUEUE_NAME}-poison",
      local.function_elt.app_settings.SERVICES_FAILURE_QUEUE_NAME,
      "${local.function_elt.app_settings.SERVICES_FAILURE_QUEUE_NAME}-poison"
    ],
    "containers"           = [],
    "blobs_retention_days" = 1,
  }

  allowed_subnets = [
    module.azdoa_snet[0].id,
  ]

  allowed_ips = local.app_insights_ips_west_europe

  # Action groups for alerts
  action = [
    {
      action_group_id    = azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}

#tfsec:ignore:azure-storage-default-action-deny
#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "storage_account_elt" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account?ref=v7.34.3"

  name                          = replace(format("%s-stelt", local.project), "-", "")
  account_kind                  = "StorageV2"
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  access_tier                   = "Hot"
  resource_group_name           = azurerm_resource_group.elt_rg.name
  location                      = var.location
  advanced_threat_protection    = true
  public_network_access_enabled = true

  tags = var.tags
}

resource "azurerm_storage_table" "fnelterrors" {
  name                 = "fnelterrors"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_table" "fnelterrors_messages" {
  name                 = "fnelterrorsMessages"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_table" "fnelterrors_message_status" {
  name                 = "fnelterrorsMessageStatus"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_table" "fnelterrors_notification_status" {
  name                 = "fnelterrorsNotificationStatus"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_table" "fneltcommands" {
  name                 = "fneltcommands"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_table" "fneltexports" {
  name                 = "fneltexports"
  storage_account_name = module.storage_account_elt.name
}

resource "azurerm_storage_container" "container_messages_report_step1" {
  name                  = "messages-report-step1"
  storage_account_name  = module.storage_account_elt.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "container_messages_report_step_final" {
  name                  = "messages-report-step-final"
  storage_account_name  = module.storage_account_elt.name
  container_access_type = "private"
}
