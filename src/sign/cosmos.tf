module "cosmosdb_account" {
  source                           = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.13.1"
  name                             = "${local.project}-cosmos"
  subnet_id                        = module.io_sign_snet.id
  location                         = azurerm_resource_group.backend_rg.location
  resource_group_name              = azurerm_resource_group.backend_rg.name
  kind                             = "GlobalDocumentDB"
  main_geo_location_location       = azurerm_resource_group.backend_rg.location
  main_geo_location_zone_redundant = false
  tags                             = var.tags
}

module "cosmosdb_sql_database_io_sign" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.13.1"
  name                = "io-sign"
  resource_group_name = azurerm_resource_group.backend_rg.name
  account_name        = module.cosmosdb_account.name
  throughput          = var.io_sign_database.throughput
}

module "cosmosdb_sql_container_signature-requests" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v2.13.1"
  name                = "signature-requests"
  resource_group_name = azurerm_resource_group.backend_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_io_sign.name
  partition_key_path  = "/signerId"
  throughput          = var.io_sign_database.signature_requests.throughput
}

