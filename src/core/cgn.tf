data "azurerm_resource_group" "cgn" {
  name = format("%s-rg-cgn", local.project)
}

## redis cgn subnet
module "redis_cgn_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.0.26"
  name                                           = format("%s-redis-cgn-snet", local.project)
  address_prefixes                               = ["10.0.14.0/25"]
  resource_group_name                            = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true
}

module "redis_cgn" {
  source                = "git::https://github.com/pagopa/azurerm.git//redis_cache?ref=v2.0.26"
  name                  = format("%s-redis-cgn-std", local.project)
  resource_group_name   = data.azurerm_resource_group.cgn.name
  location              = data.azurerm_resource_group.cgn.location
  capacity              = 1
  family                = "C"
  sku_name              = "Standard"
  enable_authentication = true

  // when azure can apply patch?
  patch_schedules = [{
    day_of_week    = "Sunday"
    start_hour_utc = 23
    },
    {
      day_of_week    = "Monday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Tuesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Wednesday"
      start_hour_utc = 23
    },
    {
      day_of_week    = "Thursday"
      start_hour_utc = 23
    },
  ]


  private_endpoint = {
    enabled              = true
    virtual_network_id   = data.azurerm_virtual_network.vnet_common.id
    subnet_id            = module.redis_cgn_snet.id
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_redis_cache.id]
  }

  tags = var.tags
}

### Function CGN ###

data "azurerm_subnet" "fn3cgn" {
  name                 = "fn3cgn"
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
}

module "function_cgn" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=function-app-slot"

  name                = format("%s-func-cgn", local.project)
  resource_group_name = data.azurerm_resource_group.cgn.name
  location            = var.location
  app_service_plan_info = {
    kind                         = "elastic"
    sku_tier                     = "ElasticPremium"
    sku_size                     = "EP1"
    maximum_elastic_worker_count = 1
  }

  runtime_version = "~3"

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME       = "node"
    WEBSITE_NODE_DEFAULT_VERSION   = "14.16.0"
    WEBSITE_RUN_FROM_PACKAGE       = "1"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4
    NODE_ENV                       = "production"

    COSMOSDB_CGN_URI           = "TODO" #dependency.cosmosdb_cgn_account.outputs.endpoint
    COSMOSDB_CGN_KEY           = "TODO" #dependency.cosmosdb_cgn_account.outputs.primary_master_key
    COSMOSDB_CGN_DATABASE_NAME = "TODO" #dependency.cosmosdb_cgn_database.outputs.name
    COSMOSDB_CONNECTION_STRING = "TODO" #dependency.cosmosdb_cgn_account.outputs.connection_strings[0]
    // Keepalive fields are all optionals<
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    CGN_EXPIRATION_TABLE_NAME  = "TODO" #dependency.storage_table_cardexpiration.outputs.name
    EYCA_EXPIRATION_TABLE_NAME = "TODO" #dependency.storage_table_eycacardexpiration.outputs.name

    # Storage account connection string:
    CGN_STORAGE_CONNECTION_STRING = "TODO" #dependency.storage_account_cgn.outputs.primary_connection_string

    SERVICES_API_URL = "TODO" # local.service_api_url


    WEBSITE_TIME_ZONE = "TODO" # local.cet_time_zone_win
    EYCA_API_BASE_URL = "https://ccdb.eyca.org/api"

    // REDIS
    REDIS_URL      = "TODO" #dependency.redis.outputs.hostname
    REDIS_PORT     = "TODO" #dependency.redis.outputs.ssl_port
    REDIS_PASSWORD = "TODO" #dependency.redis.outputs.primary_access_key

    OTP_TTL_IN_SECONDS = 600

    CGN_UPPER_BOUND_AGE  = 61
    EYCA_UPPER_BOUND_AGE = 19
  }

  /* TODO read these from the kv and set as app settings.
  app_settings_secrets = {
    key_vault_id = dependency.key_vault.outputs.id
    map = {
      SERVICES_API_KEY  = "apim-CGN-SERVICE-KEY"
      EYCA_API_USERNAME = "funccgn-EYCA-API-USERNAME"
      EYCA_API_PASSWORD = "funccgn-EYCA-API-PASSWORD"
      CGN_SERVICE_ID    = "funccgn-CGN-SERVICE-ID"
    }
  }
  */

  /*
  durable_function = {
    enable                     = true
    private_endpoint_subnet_id = dependency.subnet_pendpoints.outputs.id
    private_dns_zone_blob_ids  = [dependency.private_dns_zone_blob.outputs.id]
    private_dns_zone_queue_ids = [dependency.private_dns_zone_queue.outputs.id]
    private_dns_zone_table_ids = [dependency.private_dns_zone_table.outputs.id]
    containers                 = []
    queues                     = []
    blobs_retention_days       = 0
  }
  */

  /*
  allowed_subnets = [
    dependency.subnet.outputs.id,
    dependency.subnet_appbackendl1.outputs.id,
    dependency.subnet_appbackendl2.outputs.id,
    dependency.subnet_appbackendli.outputs.id,
    local.external_resources.locals.subnets.apimapi,
  ]
  */

  allowed_ips = local.app_insights_ips_west_europe
  subnet_id   = data.azurerm_subnet.fn3cgn.id

  tags = var.tags
}
