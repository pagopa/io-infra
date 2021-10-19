#
# Define resources for fn-pblevtdispatcher
#
# as the full name would result in a storage name too long, we user the shorter version: pblevtdispatcher
#

resource "azurerm_resource_group" "pblevtdispatcher_rg" {
  name     = format("%s-pblevtdispatcher-rg", local.project)
  location = var.location

  tags = var.tags
}

module "function_pblevtdispatcher_snetout" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.60"
  name                 = "fnpblevtdispatcherout"
  address_prefixes     = var.cidr_subnet_fnpblevtdispatcher
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
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

module "function_pblevtdispatcher" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v1.0.65"

  resource_group_name                      = azurerm_resource_group.pblevtdispatcher_rg.name
  prefix                                   = var.prefix
  env_short                                = var.env_short
  name                                     = "pblevtdispatcher"
  location                                 = var.location
  health_check_path                        = "api/v1/info"
  subnet_out_id                            = module.function_pblevtdispatcher_snetout.id
  runtime_version                          = "~3"
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind     = "elastic"
    sku_tier = "ElasticPremium"
    sku_size = "EP1"
  }

  app_settings = {
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

    COSMOS_API_CONNECTION_STRING = format("AccountEndpoint=%s;AccountKey=%s;", data.azurerm_cosmosdb_account.cosmos_api.endpoint, data.azurerm_cosmosdb_account.cosmos_api.primary_master_key)

    QUEUESTORAGE_APIEVENTS_CONNECTION_STRING = data.azurerm_storage_account.storage_apievents.primary_connection_string
    QUEUESTORAGE_APIEVENTS_EVENTS_QUEUE_NAME = azurerm_storage_queue.storage_account_apievents_events_queue.name

    # queue storage used by this function app to run async jobs
    QueueStorageConnection = module.storage_account_pblevtdispatcher.primary_connection_string

    HTTP_CALL_JOB_QUEUE_NAME = azurerm_storage_queue.storage_account_pblevtdispatcher_http_call_jobs_queue.name

    webhooks = jsonencode([
      # EUCovidCert PROD
      {
        url           = format("%s/api/v1/webhook", data.azurerm_function_app.fnapp_eucovidcert.default_hostname),
        headers       = { "X-Functions-Key" = data.azurerm_key_vault_secret.fnapp_eucovidcert_authtoken.value },
        attributes    = { serviceId = "01F73DNTMJTCEZQKJDFNB53KEB" },
        subscriptions = ["service:subscribed"]
      },
      # EUCovidCert UAT
      {
        url           = format("%s/api/v1/webhook", data.azurerm_function_app.fnapp_eucovidcert.default_hostname),
        headers       = { "X-Functions-Key" = data.azurerm_key_vault_secret.fnapp_eucovidcert_authtoken.value },
        attributes    = { serviceId = "01F798T3NX5RARB38DVKPABKV2" },
        subscriptions = ["service:subscribed"]
      }
    ])

  }

  allowed_subnets = [
    data.azurerm_subnet.azdoa_snet[0].id,
  ]

  allowed_ips = local.app_insights_ips_west_europe

  tags = var.tags
}

#tfsec:ignore:azure-storage-default-action-deny
module "storage_account_pblevtdispatcher" {
  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v1.0.60"

  name                       = replace(format("%s-stpblevtdispatcher", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "GRS"
  access_tier                = "Hot"
  resource_group_name        = azurerm_resource_group.pblevtdispatcher_rg.name
  location                   = var.location
  advanced_threat_protection = false

  # network_rules = {
  #   default_action = "Deny"
  #   ip_rules       = []
  #   bypass = [
  #     "Logging",
  #     "Metrics",
  #     "AzureServices",
  #   ]
  #   virtual_network_subnet_ids = [
  #     module.function_pblevtdispatcher_snetout.id
  #   ]
  # }

  tags = var.tags
}

resource "azurerm_storage_queue" "storage_account_pblevtdispatcher_http_call_jobs_queue" {
  name                 = "httpcalljobqueue"
  storage_account_name = module.storage_account_pblevtdispatcher.name
}
