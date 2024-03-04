locals {
  function_cgn_merchant = {
    app_settings_common = {
      FUNCTIONS_WORKER_RUNTIME       = "node"
      WEBSITE_RUN_FROM_PACKAGE       = "1"
      WEBSITE_DNS_SERVER             = "168.63.129.16"
      FUNCTIONS_WORKER_PROCESS_COUNT = 4
      NODE_ENV                       = "production"

      COSMOSDB_CGN_URI           = var.cosmos_db.endpoint
      COSMOSDB_CGN_KEY           = var.cosmos_db.primary_key
      COSMOSDB_CGN_DATABASE_NAME = "db"
      COSMOSDB_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", var.cosmos_db.endpoint, var.cosmos_db.primary_key)

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      # Storage account connection string:
      CGN_STORAGE_CONNECTION_STRING = var.cgn_storage_account_connection_string

      // REDIS
      REDIS_URL      = var.redis.hostname
      REDIS_PORT     = var.redis.ssl_port
      REDIS_PASSWORD = var.redis.primary_access_key
    }
  }

  app_settings_common = {
    FUNCTIONS_WORKER_RUNTIME       = "node"
    WEBSITE_RUN_FROM_PACKAGE       = "1"
    WEBSITE_DNS_SERVER             = "168.63.129.16"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4
    NODE_ENV                       = "production"

    COSMOSDB_CGN_URI           = var.cosmos_db.endpoint
    COSMOSDB_CGN_KEY           = var.cosmos_db.primary_key
    COSMOSDB_CGN_DATABASE_NAME = "db"
    COSMOSDB_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", var.cosmos_db.endpoint, var.cosmos_db.primary_key)

    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    CGN_EXPIRATION_TABLE_NAME  = "cardexpiration"
    EYCA_EXPIRATION_TABLE_NAME = "eycacardexpiration"

    # Storage account connection string:
    CGN_STORAGE_CONNECTION_STRING = var.cgn_storage_account_connection_string

    SERVICES_API_URL = "http://api-app.internal.io.pagopa.it/"

    WEBSITE_TIME_ZONE = "Central Europe Standard Time"
    EYCA_API_BASE_URL = "https://ccdb.eyca.org/api"

    // REDIS
    REDIS_URL      = var.redis.hostname
    REDIS_PORT     = var.redis.ssl_port
    REDIS_PASSWORD = var.redis.primary_access_key

    OTP_TTL_IN_SECONDS = 600

    CGN_UPPER_BOUND_AGE  = 36
    EYCA_UPPER_BOUND_AGE = 31

    CGN_CARDS_DATA_BACKUP_CONTAINER_NAME = "cgn-legalbackup-blob"
    CGN_CARDS_DATA_BACKUP_FOLDER_NAME    = "cgn"

    #
    # SECRETS VALUES
    #
    SERVICES_API_KEY           = data.azurerm_key_vault_secret.fn_cgn_SERVICES_API_KEY.value
    EYCA_API_USERNAME          = data.azurerm_key_vault_secret.fn_cgn_EYCA_API_USERNAME.value
    EYCA_API_PASSWORD          = data.azurerm_key_vault_secret.fn_cgn_EYCA_API_PASSWORD.value
    CGN_SERVICE_ID             = data.azurerm_key_vault_secret.fn_cgn_CGN_SERVICE_ID.value
    CGN_DATA_BACKUP_CONNECTION = data.azurerm_key_vault_secret.fn_cgn_CGN_DATA_BACKUP_CONNECTION.value
  }
}
