module "cosmosdb_sql_database_issuer" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.13.1"
  name                = "issuer"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  throughput          = var.io_sign_database_issuer.throughput
}

module "cosmosdb_sql_container_issuer-dossiers" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v2.13.1"
  name                = "dossiers"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/issuerId"

  autoscale_settings = {
    max_throughput = var.io_sign_database_issuer.dossiers.max_throughput
  }
}

module "cosmosdb_sql_container_issuer-signature-requests" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v2.13.1"
  name                = "signature-requests"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/issuerId"
  autoscale_settings = {
    max_throughput = var.io_sign_database_issuer.signature_requests.max_throughput
  }
}

module "cosmosdb_sql_container_issuer-uploads" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v2.13.1"
  name                = "uploads"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/id"
  default_ttl         = var.io_sign_database_issuer.uploads.ttl
  autoscale_settings = {
    max_throughput = var.io_sign_database_issuer.uploads.max_throughput
  }
}
