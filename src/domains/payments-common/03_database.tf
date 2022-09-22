resource "azurerm_resource_group" "data_rg" {
  name     = "${local.product}-${var.domain}-data-rg"
  location = var.location

  tags = var.tags
}


module "cosmosdb_account_mongodb" {
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.15.1"

  name                 = "${local.product}-${var.domain}-mongodb-account"
  location             = azurerm_resource_group.data_rg.location
  resource_group_name  = azurerm_resource_group.data_rg.name
  offer_type           = "Standard"
  enable_free_tier     = false
  kind                 = "MongoDB"
  capabilities         = ["EnableMongo"]
  mongo_server_version = "4.0"

  public_network_access_enabled     = false
  private_endpoint_enabled          = true
  subnet_id                         = data.azurerm_subnet.private_endpoints_subnet.id
  private_dns_zone_ids              = [data.azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.id]
  is_virtual_network_filter_enabled = false

  main_geo_location_location       = azurerm_resource_group.data_rg.location
  main_geo_location_zone_redundant = false
  additional_geo_locations = [{
    location          = "northeurope"
    failover_priority = 1
    zone_redundant    = false
  }]
  consistency_policy = {
    consistency_level       = "Session"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "db" {
  name                = "db"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account_mongodb.name

  autoscale_settings {
    max_throughput = 4000
  }
}

# Collections
module "mongdb_collection_payment" {
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection?ref=v2.3.0"

  name                = "payment"
  resource_group_name = azurerm_resource_group.data_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.db.name

  indexes = [
    {
      keys   = ["_id"]
      unique = true
    },
    {
      keys   = ["content_paymentData_payeeFiscalCode", "content_paymentData_noticeNumber"]
      unique = false
    },
  ]

  lock_enable = true
}

module "mongdb_collection_payment_retry" {
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection?ref=v2.3.0"

  name                = "payment-retry"
  resource_group_name = azurerm_resource_group.data_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.db.name

  indexes = [
    {
      keys   = ["_id"]
      unique = true
    },
    {
      keys   = ["payeeFiscalCode", "noticeNumber"]
      unique = false
    },
  ]

  lock_enable = true
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "mongodb_connection_string" {
  name         = "${module.cosmosdb_account_mongodb.name}-connection-string"
  value        = module.cosmosdb_account_mongodb.connection_strings[0]
  content_type = "full connection string"
  key_vault_id = module.key_vault.id
}
