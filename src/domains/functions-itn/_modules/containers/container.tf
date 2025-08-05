# Cosmos container for subscription cidrs
module "db_subscription_cidrs_container" {
  source              = "github.com/pagopa/terraform-azurerm-v4//cosmosdb_sql_container?ref=v7.20.0"
  name                = "subscription-cidrs"
  resource_group_name = format("%s-rg-internal", var.project)
  account_name        = format("%s-cosmos-api", var.project)
  database_name       = var.cosmos_db_name
  partition_key_paths = ["/subscriptionId"]

  autoscale_settings = {
    max_throughput = var.function_services_subscription_cidrs_max_thoughput
  }
}

import {
  to = module.containers.module.db_subscription_cidrs_container.azurerm_cosmosdb_sql_container.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/subscription-cidrs"
}
