resource "azurerm_resource_group" "data_rg" {
  name     = "${local.product}-${var.domain}-data-rg"
  location = var.location

  tags = var.tags
}

module "cosmosdb_account" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//cosmosdb_account?ref=v4.3.1"

  name                = "${local.product}-${var.domain}-account"
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

module "cosmosdb_sql_database_citizen_auth" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3//cosmosdb_sql_database?ref=v4.3.1"
  name                = "citizen-auth"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
}

#
# LolliPOP containers
#
resource "azurerm_cosmosdb_sql_container" "lollipop_pubkeys" {

  name                = "lollipop-pubkeys"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_citizen_auth.name

  partition_key_path    = "/assertionRef"
  partition_key_version = 2

  autoscale_settings {
    max_throughput = var.citizen_auth_database.lollipop_pubkeys.max_throughput
  }

  default_ttl = var.citizen_auth_database.lollipop_pubkeys.ttl

}

// ----------------------------------------------------
// Alerts
// ----------------------------------------------------

resource "azurerm_monitor_metric_alert" "cosmosdb_account_normalized_RU_consumption_exceeded" {

  name                = "[${upper(var.domain)} | ${module.cosmosdb_account.name}] Normalized RU Consumption Exceeded"
  resource_group_name = azurerm_resource_group.data_rg.name
  scopes              = [module.cosmosdb_account.id]
  description         = "A collection Normalized RU Consumption exceed the threshold, see dimensions. Please, consider to increase RU. Runbook: not needed."
  severity            = 1
  window_size         = "PT30M"
  frequency           = "PT15M"
  auto_mitigate       = false


  # Metric info
  # https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftdocumentdbdatabaseaccounts
  criteria {
    metric_namespace       = "Microsoft.DocumentDB/databaseAccounts"
    metric_name            = "NormalizedRUConsumption"
    aggregation            = "Maximum"
    operator               = "GreaterThan"
    threshold              = 90 #percentage
    skip_metric_validation = false


    dimension {
      name     = "Region"
      operator = "Include"
      values   = [var.location_full]
    }
    dimension {
      name     = "CollectionName"
      operator = "Include"
      values   = ["*"]
    }

  }

  # Action groups for alerts
  action {
    action_group_id = data.azurerm_monitor_action_group.quarantine_error_action_group.id
  }

  tags = var.tags
}

############################
# FIMS COSMOS
############################
module "cosmosdb_account_mongodb_fims" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//cosmosdb_account?ref=v4.1.5"

  name                 = "io-p-fims-mongodb-account"
  domain               = upper(var.domain)
  location             = azurerm_resource_group.data_rg.location
  resource_group_name  = azurerm_resource_group.data_rg.name
  offer_type           = "Standard"
  enable_free_tier     = false
  kind                 = "MongoDB"
  capabilities         = ["EnableMongo"]
  mongo_server_version = "4.2"

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

resource "azurerm_cosmosdb_mongo_database" "db_fims" {
  name                = "mongodb_fims"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account_mongodb_fims.name

  autoscale_settings {
    max_throughput = 5000
  }
}

# mongodb connection string for fims provider
data "azurerm_key_vault_secret" "mongodb_connection_string_fims" {
  name         = "io-p-fims-mongodb-account-connection-string"
  key_vault_id = module.key_vault.id
}
