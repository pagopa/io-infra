resource "azurerm_resource_group" "data_rg" {
  name     = "${local.product}-${var.domain}-data-rg"
  location = var.location

  tags = var.tags
}


module "cosmosdb_account_mongodb_reminder" {
  source = "github.com/pagopa/terraform-azurerm-v3//cosmosdb_account?ref=v8.27.0"

  name                 = "${local.product}-${var.domain}-reminder-mongodb-account"
  domain               = upper(var.domain)
  location             = azurerm_resource_group.data_rg.location
  resource_group_name  = azurerm_resource_group.data_rg.name
  offer_type           = "Standard"
  enable_free_tier     = false
  kind                 = "MongoDB"
  capabilities         = ["EnableMongo"]
  mongo_server_version = "4.0"

  public_network_access_enabled         = false
  private_endpoint_enabled              = true
  subnet_id                             = data.azurerm_subnet.private_endpoints_subnet.id
  private_dns_zone_mongo_ids            = [data.azurerm_private_dns_zone.privatelink_mongo_cosmos_azure_com.id]
  private_service_connection_mongo_name = "${local.product}-messages-reminder-mongodb-account-private-endpoint"
  private_endpoint_mongo_name           = "${local.product}-messages-reminder-mongodb-account-private-endpoint"
  is_virtual_network_filter_enabled     = false

  main_geo_location_location       = azurerm_resource_group.data_rg.location
  main_geo_location_zone_redundant = false
  additional_geo_locations = [{
    location          = "italynorth"
    failover_priority = 1
    zone_redundant    = true
  }]
  consistency_policy = {
    consistency_level       = "Session"
    max_interval_in_seconds = null
    max_staleness_prefix    = null
  }

  tags = var.tags
}

resource "azurerm_cosmosdb_mongo_database" "db_reminder" {
  name                = "db"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account_mongodb_reminder.name

  autoscale_settings {
    max_throughput = 4000
  }
}

# Collections
module "mongdb_collection_reminder" {
  source = "github.com/pagopa/terraform-azurerm-v3//cosmosdb_mongodb_collection?ref=v8.27.0"

  name                = "reminder"
  resource_group_name = azurerm_resource_group.data_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb_reminder.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.db_reminder.name

  indexes = [
    {
      keys   = ["_id"]
      unique = true
    },
    {
      keys   = ["rptId"]
      unique = false
    },
    {
      keys   = ["shard"]
      unique = false
    },
    {
      keys   = ["readFlag"]
      unique = false
    },
    {
      keys   = ["paidFlag"]
      unique = false
    },
    {
      keys   = ["content_type"]
      unique = false
    },
    {
      keys   = ["maxReadMessageSend"]
      unique = false
    },
    {
      keys   = ["maxPaidMessageSend"]
      unique = false
    },
    {
      keys   = ["lastDateReminder"]
      unique = false
    },
    {
      keys   = ["dueDate"]
      unique = false
    },
    {
      keys   = ["insertionDate"]
      unique = false
    },
    {
      keys   = ["content_paymentData_noticeNumber", "content_paymentData_payeeFiscalCode"]
      unique = false
    },
    {
      keys   = ["content_paymentData_dueDate"]
      unique = false
    },
  ]
}

module "mongdb_collection_reminder_sharded" {
  source = "github.com/pagopa/terraform-azurerm-v3//cosmosdb_mongodb_collection?ref=v8.27.0"

  name                = "reminder-sharded"
  resource_group_name = azurerm_resource_group.data_rg.name

  cosmosdb_mongo_account_name  = module.cosmosdb_account_mongodb_reminder.name
  cosmosdb_mongo_database_name = azurerm_cosmosdb_mongo_database.db_reminder.name

  shard_key = "shard"

  indexes = [
    {
      keys   = ["_id"]
      unique = true
    },
    {
      keys   = ["rptId"]
      unique = false
    },
    {
      keys   = ["shard"]
      unique = false
    },
    {
      keys   = ["readFlag"]
      unique = false
    },
    {
      keys   = ["paidFlag"]
      unique = false
    },
    {
      keys   = ["content_type"]
      unique = false
    },
    {
      keys   = ["maxReadMessageSend"]
      unique = false
    },
    {
      keys   = ["maxPaidMessageSend"]
      unique = false
    },
    {
      keys   = ["lastDateReminder"]
      unique = false
    },
    {
      keys   = ["dueDate"]
      unique = false
    },
    {
      keys   = ["insertionDate"]
      unique = false
    },
    {
      keys   = ["content_paymentData_noticeNumber", "content_paymentData_payeeFiscalCode"]
      unique = false
    },
    {
      keys   = ["content_paymentData_dueDate"]
      unique = false
    },
  ]
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "mongodb_connection_string_reminder" {
  name         = "${module.cosmosdb_account_mongodb_reminder.name}-connection-string"
  value        = module.cosmosdb_account_mongodb_reminder.connection_strings[0]
  content_type = "full connection string"
  key_vault_id = module.key_vault.id
}
