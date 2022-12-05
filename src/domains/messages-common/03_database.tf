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
###################################
# Database Reminder Mysql
###################################
data "azurerm_key_vault_secret" "reminder_mysql_db_server_adm_username" {
  name         = "${local.product}-${var.domain}-REMINDER-MYSQL-DB-ADM-USERNAME"
  key_vault_id = module.key_vault.id
}
data "azurerm_key_vault_secret" "reminder_mysql_db_server_adm_password" {
  name         = "${local.product}-${var.domain}-REMINDER-MYSQL-DB-ADM-PASSWORD"
  key_vault_id = module.key_vault.id
}

module "reminder_mysql_db_server_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-snet", "reminder-mysql")
  address_prefixes                               = ["10.0.155.16/28"]
  resource_group_name                            = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_common.name
  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Storage"]
  delegation = {
    name = "fs"
    service_delegation = {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_mysql_flexible_server" "reminder_mysql_server" {
  name                   = "${local.product}-${var.domain}-reminder-mysql"
  location               = azurerm_resource_group.data_rg.location
  resource_group_name    = azurerm_resource_group.data_rg.name
  administrator_login    = data.azurerm_key_vault_secret.reminder_mysql_db_server_adm_username.value
  administrator_password = data.azurerm_key_vault_secret.reminder_mysql_db_server_adm_password.value
  backup_retention_days  = 7
  private_dns_zone_id    = data.azurerm_private_dns_zone.privatelink_mysql_azure_com.id
  delegated_subnet_id    = module.reminder_mysql_db_server_snet.id
  version                = "8.0.21"
  sku_name               = "B_Standard_B1ms"
  zone                   = "3"
}

resource "azurerm_mysql_flexible_database" "reminder_mysql_db" {
  name                = "reminder"
  resource_group_name = azurerm_resource_group.data_rg.name
  server_name         = azurerm_mysql_flexible_server.reminder_mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_flexible_server_configuration" "max_connections" {
  name                = "max_connections"
  resource_group_name = azurerm_resource_group.data_rg.name
  server_name         = azurerm_mysql_flexible_server.reminder_mysql_server.name
  value               = "341"
}

resource "azurerm_key_vault_secret" "reminder_mysql_db_server_url" {
  name = "${azurerm_mysql_flexible_server.reminder_mysql_server.name}-REMINDER-MYSQL-DB-URL"
  value = format("jdbc:mysql://%s:%s/%s",
    trimsuffix(azurerm_mysql_flexible_server.reminder_mysql_server.fqdn, "."),
    "3306",
  azurerm_mysql_flexible_database.reminder_mysql_db.name)
  content_type = "text/plain"
  key_vault_id = module.key_vault.id
}