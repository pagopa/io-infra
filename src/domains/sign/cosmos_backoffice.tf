module "cosmosdb_sql_database_backoffice" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database?ref=v4.1.3"
  name                = "backoffice"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
}

module "cosmosdb_sql_container_backoffice-api-keys" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v4.1.11"
  name                = "api-keys"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_backoffice.name
  partition_key_path  = "/institutionId"

  autoscale_settings = {
    max_throughput = var.io_sign_database_backoffice.api_keys.max_throughput
  }

  default_ttl = var.io_sign_database_backoffice.api_keys.ttl
}
