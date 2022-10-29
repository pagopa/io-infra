module "cosmosdb_account" {
  source                           = "git::https://github.com/pagopa/azurerm.git//cosmosdb_account?ref=v2.13.1"
  name                             = "${local.project}-cosmos"
  location                         = azurerm_resource_group.data_rg.location
  resource_group_name              = azurerm_resource_group.data_rg.name
  kind                             = "GlobalDocumentDB"
  main_geo_location_location       = azurerm_resource_group.data_rg.location
  main_geo_location_zone_redundant = false

  public_network_access_enabled = false

  is_virtual_network_filter_enabled = true

  private_endpoint_enabled           = true
  subnet_id                          = data.azurerm_subnet.private_endpoints_subnet.id
  private_dns_zone_ids               = [data.azurerm_private_dns_zone.privatelink_documents_azure_com.id]
  allowed_virtual_network_subnet_ids = [module.io_sign_snet.id]

  tags = var.tags
}

module "cosmosdb_sql_database_db" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_database?ref=v2.13.1"
  name                = "db"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  throughput          = var.io_sign_database.throughput
}

module "cosmosdb_sql_container_signature-requests" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v3.2.5"
  name                = "signature-requests"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_db.name
  partition_key_path  = "/subscriptionId"
  # throughput          = must be managed manually to avoid problems with terraform
}

module "cosmosdb_sql_container_products" {
  source              = "git::https://github.com/pagopa/azurerm.git//cosmosdb_sql_container?ref=v3.2.5"
  name                = "products"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_db.name
  partition_key_path  = "/subscriptionId"
  # throughput          = must be managed manually to avoid problems with terraform
}

