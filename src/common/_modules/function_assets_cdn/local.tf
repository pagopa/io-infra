locals {
  function_assets_cdn = {
    app_settings = {
      WEBSITE_RUN_FROM_PACKAGE = "1"
      WEBSITE_DNS_SERVER       = "168.63.129.16"
      NODE_ENV                 = "production"

      // Keepalive fields are all optionals
      FETCH_KEEPALIVE_ENABLED             = "true"
      FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
      FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
      FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
      FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
      FETCH_KEEPALIVE_TIMEOUT             = "60000"

      COSMOSDB_URI  = data.azurerm_cosmosdb_account.cosmos_api.endpoint
      COSMOSDB_KEY  = data.azurerm_cosmosdb_account.cosmos_api.primary_key
      COSMOSDB_NAME = "db"

      STATIC_WEB_ASSETS_ENDPOINT  = data.azurerm_storage_account.assets_cdn.primary_web_host
      STATIC_BLOB_ASSETS_ENDPOINT = data.azurerm_storage_account.assets_cdn.primary_blob_host

      CachedStorageConnection = data.azurerm_storage_account.storage_api.primary_connection_string
      AssetsStorageConnection = data.azurerm_storage_account.assets_cdn.primary_connection_string

      AzureWebJobsFeatureFlags = "EnableProxies"
    }
  }
}

locals {
  project            = "${var.prefix}-${var.env_short}"
  vnet_common_name   = format("%s-vnet-common", local.project)
  rg_common_name     = format("%s-rg-common", local.project)
  rg_internal_name   = format("%s-rg-internal", local.project)
  rg_assets_cdn_name = format("%s-assets-cdn-rg", local.project)

  apim_itn_name = "${local.project}-${var.location_itn}-apim-01"
}