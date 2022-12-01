data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.product)
  resource_group_name = format("%s-rg-internal", local.product)
}

resource "azurerm_key_vault_secret" "cosmos_api_master_key" {
  name         = "${data.azurerm_cosmosdb_account.cosmos_api.name}-master-key"
  value        = data.azurerm_cosmosdb_account.cosmos_api.primary_master_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_resource_group" "data_rg" {
  name     = "${local.product}-${var.domain}-data-rg"
  location = var.location

  tags = var.tags
}


module "cosmosdb_account_mongodb_reminder" {
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.15.1"

  name                 = "${local.product}-${var.domain}-reminder-mongodb-account"
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
  source = "git::https://github.com/pagopa/azurerm.git//cosmosdb_mongodb_collection?ref=v2.3.0"

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

#
# Reminder PostgreSQL
#
// db admin user credentials
data "azurerm_key_vault_secret" "reminder_postgresql_db_server_adm_username" {
  name         = "${local.product}-${var.domain}-DB-ADM-USERNAME"
  key_vault_id = module.key_vault.id
}
data "azurerm_key_vault_secret" "reminder_postgresql_db_server_adm_password" {
  name         = "${local.product}-${var.domain}-DB-ADM-PASSWORD"
  key_vault_id = module.key_vault.id
}

## ?????? 
module "reminder_postgresql_db_server_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-snet", "reminder-postgresql")
  address_prefixes                               = ["10.0.155.0/28"]
  resource_group_name                            = data.azurerm_virtual_network.vnet_common.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.resource_group_name
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

module "reminder_postgresql_db_server" {
  source = "git::https://github.com/pagopa/azurerm.git//postgres_flexible_server?ref=v2.19.1"

  name                = "${local.product}-${var.domain}-reminder-postgresql"
  location             = azurerm_resource_group.data_rg.location
  resource_group_name  = azurerm_resource_group.data_rg.name

  administrator_login    = data.azurerm_key_vault_secret.reminder_postgresql_db_server_adm_username.value
  administrator_password = data.azurerm_key_vault_secret.reminder_postgresql_db_server_adm_password.value

  sku_name                     = "Standard_B1ms"
  db_version                   = 13
  geo_redundant_backup_enabled = false

  private_endpoint_enabled = true
  private_dns_zone_id      = data.azurerm_private_dns_zone.privatelink_postgres_azure_com.id
  delegated_subnet_id      = module.reminder_postgresql_db_server_snet.id

  high_availability_enabled = false

  pgbouncer_enabled = true

  storage_mb = 1024 # 1GB

  alerts_enabled = true

  diagnostic_settings_enabled = false

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "reminder_postgresql_db" {
  name       = "db"
  server_id  = module.reminder_postgresql_db_server.id
  charset    = "UTF8"
  collation  = "en_US.utf8"
  depends_on = [module.reminder_postgresql_db_server]
}

resource "azurerm_key_vault_secret" "reminder_postgresql_db_server_url" {
  name         = "${module.reminder_postgresql_db_server.name}-DB-URL"
  value        = format("jdbc:postgresql://%s:%s/%s?%s", 
                        trimsuffix(module. reminder_postgresql_db_server.fqdn, "."), 
                        module. reminder_postgresql_db_server.connection_port,
                        module. reminder_postgresql_db_server.name, 
                        "sslmode=require")
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}