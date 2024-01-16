module "cosmosdb_sql_database_backoffice" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database?ref=v7.46.0"
  name                = "backoffice"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
}

module "cosmosdb_sql_container_backoffice-api-keys" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.46.0"
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

module "cosmosdb_sql_container_backoffice-issuers" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.46.0"
  name                = "issuers"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_backoffice.name
  partition_key_path  = "/institutionId"

  autoscale_settings = {
    max_throughput = var.io_sign_database_backoffice.issuers.max_throughput
  }

  default_ttl = var.io_sign_database_backoffice.issuers.ttl
}

module "cosmosdb_sql_container_backoffice-consents" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.46.0"
  name                = "consents"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_backoffice.name
  partition_key_path  = "/institutionId"

  autoscale_settings = {
    max_throughput = var.io_sign_database_backoffice.consents.max_throughput
  }

  default_ttl = var.io_sign_database_backoffice.consents.ttl
}
