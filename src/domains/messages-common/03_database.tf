data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.product)
  resource_group_name = format("%s-rg-internal", local.product)
}

resource "azurerm_key_vault_secret" "cosmos_api_master_key" {
  name         = "${data.azurerm_cosmosdb_account.cosmos_api.name}-master-key"
  value        = data.azurerm_cosmosdb_account.cosmos_api.primary_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}

resource "azurerm_resource_group" "data_rg" {
  name     = "${local.product}-${var.domain}-data-rg"
  location = var.location

  tags = var.tags
}


module "cosmosdb_account_mongodb_reminder" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//cosmosdb_account?ref=v4.1.5"

  name                 = "${local.product}-${var.domain}-reminder-mongodb-account"
  domain               = upper(var.domain)
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
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//cosmosdb_mongodb_collection?ref=v4.1.5"

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
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3//subnet?ref=v4.1.5"
  name                                      = format("%s-snet", "reminder-mysql")
  address_prefixes                          = ["10.0.155.16/28"]
  resource_group_name                       = data.azurerm_virtual_network.vnet_common.resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet_common.name
  private_endpoint_network_policies_enabled = false
  service_endpoints                         = ["Microsoft.Storage"]
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
  charset             = "utf8mb3"
  collation           = "utf8mb3_unicode_ci"
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


############################
# REMOTE CONTENT COSMOS
############################
module "cosmosdb_account_remote_content" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//cosmosdb_account?ref=v4.3.1"

  name                = "${local.product}-${var.domain}-remote-content"
  domain              = upper(var.domain)
  location            = azurerm_resource_group.data_rg.location
  resource_group_name = azurerm_resource_group.data_rg.name
  offer_type          = "Standard"
  enable_free_tier    = false
  kind                = "GlobalDocumentDB"

  public_network_access_enabled     = false
  private_endpoint_enabled          = true
  subnet_id                         = data.azurerm_subnet.private_endpoints_subnet.id
  private_dns_zone_ids              = [data.azurerm_private_dns_zone.privatelink_documents_azure_com.id]
  is_virtual_network_filter_enabled = false

  main_geo_location_location       = azurerm_resource_group.data_rg.location
  main_geo_location_zone_redundant = true

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

  # Action groups for alerts
  action = [
    {
      action_group_id    = data.azurerm_monitor_action_group.error_action_group.id
      webhook_properties = {}
    }
  ]

  tags = var.tags
}

module "cosmosdb_sql_database_remote_content" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3//cosmosdb_sql_database?ref=v4.3.1"
  name                = "remote-content"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account_remote_content.name
}

resource "azurerm_cosmosdb_sql_container" "remote_content_configuration" {

  name                = "remote-content-configuration"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account_remote_content.name
  database_name       = module.cosmosdb_sql_database_remote_content.name

  partition_key_path    = "/serviceId"
  partition_key_version = 2

  autoscale_settings {
    max_throughput = 2000
  }

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    excluded_path {
      path = "/\"_etag\"/?"
    }
  }
}

resource "azurerm_cosmosdb_sql_container" "message-configuration" {
  name                = "message-configuration"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account_remote_content.name
  database_name       = module.cosmosdb_sql_database_remote_content.name

  partition_key_path    = "/configurationId"
  partition_key_version = 2

  autoscale_settings {
    max_throughput = 2000
  }

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    excluded_path {
      path = "/\"_etag\"/?"
    }
  }
}
