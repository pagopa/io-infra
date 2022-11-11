module "cosmosdb_sql_database_user" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.13.1"
  name                = "user"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  throughput          = var.io_sign_database_user.throughput
}

module "cosmosdb_sql_container_user-signature-requests" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v2.13.1"
  name                = "signature-requests"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_user.name
  partition_key_path  = "/signerId"

  autoscale_settings = {
    max_throughput = var.io_sign_database_user.signature_requests.max_throughput
  }
}
