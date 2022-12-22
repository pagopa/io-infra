module "cosmosdb_sql_database_user" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.7.2"
  name                = "user"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
}

module "cosmosdb_sql_container_user-signature-requests" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v3.2.5"
  name                = "signature-requests"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_user.name
  partition_key_path  = "/signerId"

  # TODO [SFEQS-1200] Refactor to provider v3
  # autoscale_settings = {
  #   max_throughput = var.io_sign_database_user.signature_requests.max_throughput
  # }

  default_ttl = var.io_sign_database_user.signature_requests.ttl
}

module "cosmosdb_sql_container_user-signatures" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v3.2.5"
  name                = "signatures"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_user.name
  partition_key_path  = "/signerId"

  # TODO [SFEQS-1200] Refactor to provider v3
  # autoscale_settings = {
  #   max_throughput = var.io_sign_database_user.signatures.max_throughput
  # }

  default_ttl = var.io_sign_database_user.signatures.ttl
}
