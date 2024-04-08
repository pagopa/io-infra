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
      TARGETKAFKA_brokers             = local.event_hub_connection
      TARGETKAFKA_ssl                 = "true"
      TARGETKAFKA_sasl_mechanism      = "plain"
      TARGETKAFKA_sasl_username       = "$ConnectionString"
      TARGETKAFKA_sasl_password       = data.azurerm_eventhub_authorization_rule.evh_ns_io_cosmos_fn.primary_connection_string
      TARGETKAFKA_maxInFlightRequests = "1"
      TARGETKAFKA_idempotent          = "true"
      TARGETKAFKA_transactionalId     = "IO_ELT"
      TARGETKAFKA_topic               = "io-cosmosdb-services"

      SERVICES_TOPIC_NAME              = "io-cosmosdb-services"
      SERVICES_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_io_cosmos_fn.primary_connection_string
      SERVICES_LEASES_PREFIX           = "services-001"

      MESSAGES_TOPIC_NAME              = "pdnd-io-cosmosdb-messages"
      MESSAGES_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_pdnd_io_cosmos_fn.primary_connection_string
      MESSAGES_LEASES_PREFIX           = "messages-001"

      MESSAGE_STATUS_TOPIC_NAME              = "pdnd-io-cosmosdb-message-status"
      MESSAGE_STATUS_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_pdnd_io_cosmos_message_status_fn.primary_connection_string
      MESSAGE_STATUS_LEASES_PREFIX           = "message-status-001"

      NOTIFICATION_STATUS_TOPIC_NAME              = "pdnd-io-cosmosdb-notification-status"
      NOTIFICATION_STATUS_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_pdnd_io_cosmos_notification_status_fn.primary_connection_string
      NOTIFICATION_STATUS_LEASES_PREFIX           = "notification-status-001"

      ERROR_STORAGE_ACCOUNT                   = var.storage_account_name
      ERROR_STORAGE_KEY                       = var.storage_account_primary_access_key
      ERROR_STORAGE_TABLE                     = var.storage_account_tables.fnelterrors
      ERROR_STORAGE_TABLE_MESSAGES            = var.storage_account_tables.fnelterrors_messages
      ERROR_STORAGE_TABLE_MESSAGE_STATUS      = var.storage_account_tables.fnelterrors_message_status
      ERROR_STORAGE_TABLE_NOTIFICATION_STATUS = var.storage_account_tables.fnelterrors_notification_status

      COMMAND_STORAGE                = var.storage_account_primary_connection_string
      COMMAND_STORAGE_TABLE          = var.storage_account_tables.fneltcommands
      IMPORT_TOPIC_NAME              = "import-command"
      IMPORT_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_import_command_fn.primary_connection_string

      PROFILE_TOPIC_NAME              = "io-cosmosdb-profiles"
      PROFILE_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_io_cosmos_profiles_fn.primary_connection_string

      COSMOSDB_REPLICA_NAME     = "db"
      COSMOSDB_REPLICA_URI      = replace(data.azurerm_cosmosdb_account.cosmos_api.endpoint, "io-p-cosmos-api", "io-p-cosmos-api-northeurope")
      COSMOSDB_REPLICA_KEY      = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOSDB_REPLICA_LOCATION = var.secondary_location_display_name

      MESSAGE_EXPORTS_COMMAND_TABLE       = var.storage_account_tables.fneltexports
      MESSAGE_EXPORT_STEP_1_CONTAINER     = var.storage_account_containers.container_messages_report_step1
      MESSAGE_EXPORT_STEP_FINAL_CONTAINER = var.storage_account_containers.container_messages_report_step_final

      COSMOS_CHUNK_SIZE            = "1000"
      COSMOS_DEGREE_OF_PARALLELISM = "2"
      MESSAGE_CONTENT_CHUNK_SIZE   = "200"

      SERVICEID_EXCLUSION_LIST = data.azurerm_key_vault_secret.services_exclusion_list.value

      PN_SERVICE_ID = local.pn_service_id

      #iopstapi connection string
      MessageContentPrimaryStorageConnection = data.azurerm_storage_account.storage_api.primary_connection_string
      #iopstapireplica connection string
      MessageContentStorageConnection  = data.azurerm_storage_account.storage_api_replica.primary_connection_string
      ServiceInfoBlobStorageConnection = data.azurerm_storage_account.storage_assets_cdn.primary_connection_string

      MESSAGES_FAILURE_QUEUE_NAME       = "pdnd-io-cosmosdb-messages-failure"
      MESSAGE_STATUS_FAILURE_QUEUE_NAME = "pdnd-io-cosmosdb-message-status-failure"
      SERVICES_FAILURE_QUEUE_NAME       = "pdnd-io-cosmosdb-services-failure"

      INTERNAL_TEST_FISCAL_CODES = module.tests.test_users.all
    }
  }
}

#tfsec:ignore:azure-storage-queue-services-logging-enabled:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "function_elt" {
  source = "github.com/pagopa/terraform-azurerm-v3//function_app?ref=v7.67.1"

  resource_group_name = var.resource_group_name
  name                = "${var.project}-fn-elt"
  location            = var.location
  domain              = "IO-COMMONS"

  storage_account_name                     = "${replace(var.project, "-", "")}stfnelt"
  app_service_plan_name                    = "${var.project}-plan-fnelt"
  health_check_path                        = "/api/v1/info"
  subnet_id                                = var.subnet_id
  runtime_version                          = "~4"
  node_version                             = "18"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

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
    account_replication_type          = "GZRS"
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
    use_legacy_defender_version       = false
  }

  internal_storage = {
    "enable"                     = true,
    "private_endpoint_subnet_id" = data.azurerm_subnet.private_endpoints_subnet.id
    "private_dns_zone_blob_ids"  = [data.azurerm_private_dns_zone.privatelink_blob_core.id],
    "private_dns_zone_queue_ids" = [data.azurerm_private_dns_zone.privatelink_queue_core.id],
    "private_dns_zone_table_ids" = [data.azurerm_private_dns_zone.privatelink_table_core.id],
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
    data.azurerm_subnet.snet_azdoa.id,
  ]

  allowed_ips = local.app_insights_ips_west_europe

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}
