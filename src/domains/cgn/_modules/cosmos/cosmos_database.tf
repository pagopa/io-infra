module "cgn_cosmos_db" {
  source              = "github.com/pagopa/terraform-azurerm-v3//cosmosdb_sql_database?ref=v7.61.0"
  name                = "db"
  resource_group_name = var.resource_group_name
  account_name        = module.cosmos_cgn.name
}
