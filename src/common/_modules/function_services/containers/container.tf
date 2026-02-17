# Cosmos container for subscription cidrs
module "db_subscription_cidrs_container" {
  source              = "github.com/pagopa/terraform-azurerm-v4//cosmosdb_sql_container?ref=v7.20.0"
  name                = "subscription-cidrs"
  resource_group_name = var.resource_group_name
  account_name        = format("%s-cosmos-api", var.legacy_project)
  database_name       = var.cosmos_db_name
  partition_key_paths = ["/subscriptionId"]

  autoscale_settings = {
    max_throughput = var.function_services_subscription_cidrs_max_thoughput
  }
}
