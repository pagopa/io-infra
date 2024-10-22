# Containers

module "db_subscription_profileemails_container" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//cosmosdb_sql_container?ref=v8.52.0"
  name                = "profile-emails-leases"
  resource_group_name = format("%s-rg-internal", local.project)
  account_name        = format("%s-cosmos-api", local.project)
  database_name       = "db"
  partition_key_path  = "/_partitionKey"

  autoscale_settings = {
    max_throughput = 1000
  }
}
