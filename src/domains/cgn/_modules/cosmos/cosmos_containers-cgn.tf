module "cgn_cosmosdb_containers" {
  for_each = { for c in local.cgn_cosmosdb_containers : c.name => c }

  source = "github.com/pagopa/terraform-azurerm-v3//cosmosdb_sql_container?ref=v7.63.0"

  name                = each.value.name
  resource_group_name = var.resource_group_name
  account_name        = module.cosmos_cgn.name
  database_name       = module.cgn_cosmos_db.name
  partition_key_path  = each.value.partition_key_path
  throughput          = lookup(each.value, "throughput", null)

  autoscale_settings = lookup(each.value, "autoscale_settings", null)
}
