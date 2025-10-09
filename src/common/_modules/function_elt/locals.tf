locals {
  function_elt = {
    app_settings = {

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      APPLICATIONINSIGHTS_CONNECTION_STRING = data.azurerm_application_insights.application_insights.connection_string

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

      // A&I Event Hub
      TARGETKAFKAAUTH_clientId            = "IO_FUNCTIONS_ELT"
      TARGETKAFKAAUTH_brokers             = local.auth_event_hub_connection
      TARGETKAFKAAUTH_ssl                 = "true"
      TARGETKAFKAAUTH_maxInFlightRequests = "1"
      TARGETKAFKAAUTH_idempotent          = "true"
      TARGETKAFKAAUTH_transactionalId     = "IO_ELT"
      TARGETKAFKAAUTH_topic               = "dummy" #Needed by KafkaProducerTopicConfig decoder

      SERVICE_PREFERENCES_TOPIC_NAME              = data.azurerm_eventhub_authorization_rule.evh_ns_service_preferences_send_auth_rule.eventhub_name
      SERVICE_PREFERENCES_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_service_preferences_send_auth_rule.primary_connection_string
      SERVICE_PREFERENCES_LEASES_PREFIX           = "service-preferences-004"

      PROFILES_TOPIC_NAME              = data.azurerm_eventhub_authorization_rule.evh_ns_profiles_send_auth_rule.eventhub_name
      PROFILES_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_profiles_send_auth_rule.primary_connection_string
      PROFILES_LEASES_PREFIX           = "profiles-004"

      DELETES_TOPIC_NAME              = data.azurerm_eventhub_authorization_rule.evh_ns_profile_deletion_send_auth_rule.eventhub_name
      DELETES_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_profile_deletion_send_auth_rule.primary_connection_string
      DELETES_LEASES_PREFIX           = "profile-deletion-002"


      ERROR_STORAGE_ACCOUNT                   = var.storage_account_name
      ERROR_STORAGE_KEY                       = var.storage_account_primary_access_key
      ERROR_STORAGE_TABLE                     = var.storage_account_tables.fnelterrors
      ERROR_STORAGE_TABLE_MESSAGES            = var.storage_account_tables.fnelterrors_messages
      ERROR_STORAGE_TABLE_MESSAGE_STATUS      = var.storage_account_tables.fnelterrors_message_status
      ERROR_STORAGE_TABLE_NOTIFICATION_STATUS = var.storage_account_tables.fnelterrors_notification_status

      COMMAND_STORAGE                = var.storage_account_primary_connection_string
      BLOB_COMMAND_STORAGE           = var.storage_account_itn_primary_connection_string
      COMMAND_STORAGE_TABLE          = var.storage_account_tables.fneltcommands
      IMPORT_TOPIC_NAME              = "import-command"
      IMPORT_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_import_command_fn.primary_connection_string

      PROFILE_TOPIC_NAME              = "io-cosmosdb-profiles"
      PROFILE_TOPIC_CONNECTION_STRING = data.azurerm_eventhub_authorization_rule.evh_ns_io_cosmos_profiles_fn.primary_connection_string

      COSMOSDB_REPLICA_NAME     = "db"
      COSMOSDB_REPLICA_URI      = data.azurerm_cosmosdb_account.cosmos_api.endpoint
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

      MESSAGES_FAILURE_QUEUE_NAME            = "pdnd-io-cosmosdb-messages-failure"
      MESSAGE_STATUS_FAILURE_QUEUE_NAME      = "pdnd-io-cosmosdb-message-status-failure"
      SERVICES_FAILURE_QUEUE_NAME            = "pdnd-io-cosmosdb-services-failure"
      SERVICE_PREFERENCES_FAILURE_QUEUE_NAME = local.service_preferences_failure_queue_name
      PROFILES_FAILURE_QUEUE_NAME            = local.profiles_failure_queue_name
      DELETES_FAILURE_QUEUE_NAME             = local.profile_deletion_failure_queue_name

      # PDV integration env variables
      PDV_TOKENIZER_API_KEY   = data.azurerm_key_vault_secret.pdv_tokenizer_api_key.value,
      PDV_TOKENIZER_BASE_URL  = "https://api.tokenizer.pdv.pagopa.it",
      PDV_TOKENIZER_BASE_PATH = "/tokenizer/v1",
      #

      # TODO: remove after compressed variant has been rolled out
      INTERNAL_TEST_FISCAL_CODES = module.tests.users.all

      INTERNAL_TEST_FISCAL_CODES_COMPRESSED = base64gzip(module.tests.users.all)

      # REDIS CACHE CONFIG FOR PDV IDs
      REDIS_URL      = data.azurerm_redis_cache.ioauth_redis_common_itn.hostname
      REDIS_PORT     = data.azurerm_redis_cache.ioauth_redis_common_itn.ssl_port
      REDIS_PASSWORD = data.azurerm_redis_cache.ioauth_redis_common_itn.primary_access_key
    }
  }
}

locals {

  resource_group_name_common   = "${var.project}-rg-common"
  resource_group_name_internal = "${var.project}-rg-internal"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  event_hub_connection      = "${format("%s-evh-ns", var.project)}.servicebus.windows.net:9093"
  auth_event_hub_connection = "${format("%s-itn-auth-elt-evhns-01", var.project)}.servicebus.windows.net:9093"

  pn_service_id = "01G40DWQGKY5GRWSNM4303VNRP"

  service_preferences_failure_queue_name = "pdnd-io-cosmosdb-service-preferences-failure"
  profiles_failure_queue_name            = "pdnd-io-cosmosdb-profiles-failure"
  profile_deletion_failure_queue_name    = "pdnd-io-cosmosdb-profile-deletion-failure"
}
