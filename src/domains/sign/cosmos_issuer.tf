module "cosmosdb_sql_database_issuer" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_database?ref=v7.46.0"
  name                = "issuer"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
}

module "cosmosdb_sql_container_issuer-dossiers" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.46.0"
  name                = "dossiers"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/issuerId"

  autoscale_settings = {
    max_throughput = var.io_sign_database_issuer.dossiers.max_throughput
  }

  default_ttl = var.io_sign_database_issuer.dossiers.ttl
}

module "cosmosdb_sql_container_issuer-signature-requests" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.46.0"
  name                = "signature-requests"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/issuerId"

  autoscale_settings = {
    max_throughput = var.io_sign_database_issuer.signature_requests.max_throughput
  }

  default_ttl = var.io_sign_database_issuer.signature_requests.ttl
}

module "cosmosdb_sql_container_issuer-uploads" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.46.0"
  name                = "uploads"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/id"

  autoscale_settings = {
    max_throughput = var.io_sign_database_issuer.uploads.max_throughput
  }

  default_ttl = var.io_sign_database_issuer.uploads.ttl
}

module "cosmosdb_sql_container_issuer-issuers" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.46.0"
  name                = "issuers"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/subscriptionId"

  autoscale_settings = {
    max_throughput = var.io_sign_database_issuer.uploads.max_throughput
  }

  default_ttl = var.io_sign_database_issuer.issuers.ttl
}

module "cosmosdb_sql_container_issuer-issuers-by-vat-number" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.46.0"
  name                = "issuers-by-vat-number"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/id"

  autoscale_settings = {
    max_throughput = var.io_sign_database_issuer.uploads.max_throughput
  }

  default_ttl = var.io_sign_database_issuer.issuers.ttl
}

module "cosmosdb_sql_container_issuer-issuers-by-subscription-id" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.46.0"
  name                = "issuers-by-subscription-id"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/id"

  autoscale_settings = {
    max_throughput = var.io_sign_database_issuer.uploads.max_throughput
  }

  default_ttl = var.io_sign_database_issuer.issuers.ttl
}

module "cosmosdb_sql_container_issuer-issuers-whitelist" {
  source              = "github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v7.46.0"
  name                = "issuers-whitelist"
  resource_group_name = azurerm_resource_group.data_rg.name
  account_name        = module.cosmosdb_account.name
  database_name       = module.cosmosdb_sql_database_issuer.name
  partition_key_path  = "/id"

  autoscale_settings = {
    max_throughput = var.io_sign_database_issuer.uploads.max_throughput
  }

  default_ttl = var.io_sign_database_issuer.issuers.ttl
}
