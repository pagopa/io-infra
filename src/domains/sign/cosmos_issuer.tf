module "cosmosdb_sql_database_issuer" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.7.2"
  name                = "issuer"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
}

module "cosmosdb_sql_container_issuer-dossiers" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v3.2.5"
  name                = "dossiers"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/issuerId"

  # TODO [SFEQS-1200] Refactor to provider v3
  # autoscale_settings = {
  #   max_throughput = var.io_sign_database_issuer.dossiers.max_throughput
  # }

  default_ttl = var.io_sign_database_issuer.dossiers.ttl
}

module "cosmosdb_sql_container_issuer-signature-requests" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v3.2.5"
  name                = "signature-requests"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/issuerId"

  # TODO [SFEQS-1200] Refactor to provider v3
  # autoscale_settings = {
  #   max_throughput = var.io_sign_database_issuer.signature_requests.max_throughput
  # }

  default_ttl = var.io_sign_database_issuer.signature_requests.ttl
}

module "cosmosdb_sql_container_issuer-uploads" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v3.2.5"
  name                = "uploads"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/id"

  # TODO [SFEQS-1200] Refactor to provider v3
  # autoscale_settings = {
  #   max_throughput = var.io_sign_database_issuer.uploads.max_throughput
  # }

  default_ttl = var.io_sign_database_issuer.uploads.ttl
}

module "cosmosdb_sql_container_issuer-issuers" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v3.2.5"
  name                = "issuers"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/subscriptionId"


  # TODO [SFEQS-1200] Refactor to provider v3
  # autoscale_settings = {
  #   max_throughput = var.io_sign_database_issuer.uploads.max_throughput
  # }

  default_ttl = var.io_sign_database_issuer.issuers.ttl
}
