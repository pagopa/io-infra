module "cosmos_database_cgn" {
  source = "github.com/pagopa/terraform-azurerm-v3//cosmosdb_sql_database?ref=v7.64.0"

  name                = "db"
  resource_group_name = var.resource_group_name

  account_name = module.cosmos_account_cgn.name
}
