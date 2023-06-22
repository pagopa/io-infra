data "azurerm_resource_group" "data_rg" {
  name     = format("%s-%s-data-rg", local.product, var.domain)
  location = var.location
  tags = var.tags
}

# CITIZEN AUTH
data "azurerm_cosmosdb_account" "cosmos_citizen_auth" {
  name                = format("%s-%s-account", local.product, var.domain)
  resource_group_name = data.azurerm_resource_group.data_rg.name
}

# FIMS
module "cosmosdb_account_mongodb_fims" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//cosmosdb_account?ref=v4.1.5"

  name                 = "${local.product}-${var.domain}-fims-mongodb-account"
  domain               = upper(var.domain)
  location             = data.azurerm_resource_group.data_rg.location
  resource_group_name  = data.azurerm_resource_group.data_rg.name
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

  main_geo_location_location       = data.azurerm_resource_group.data_rg.location
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
  name                = "db"
  resource_group_name = data.azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account_mongodb_fims.name

  autoscale_settings {
    max_throughput = 5000
  }
}

#tfsec:ignore:AZU023
resource "azurerm_key_vault_secret" "mongodb_connection_string_fims" {
  name         = "${module.cosmosdb_account_mongodb_fims.name}-connection-string"
  value        = module.cosmosdb_account_mongodb_fims.connection_strings[0]
  content_type = "full connection string"
  key_vault_id = module.key_vault.id
}