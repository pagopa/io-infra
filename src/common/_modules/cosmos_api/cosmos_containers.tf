import {
  to = azurerm_cosmosdb_sql_container.these["profile-emails-uniqueness-leases-itn-002"]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-internal/providers/Microsoft.DocumentDB/databaseAccounts/io-p-cosmos-api/sqlDatabases/db/containers/profile-emails-uniqueness-leases-itn-002"
}

resource "azurerm_cosmosdb_sql_container" "these" {
  for_each = { for c in local.cosmosdb_containers : c.name => c }

  name                = each.value.name
  resource_group_name = azurerm_cosmosdb_account.this.resource_group_name

  account_name  = azurerm_cosmosdb_account.this.name
  database_name = azurerm_cosmosdb_sql_database.db.name

  partition_key_paths   = [each.value.partition_key_path]
  partition_key_version = lookup(each.value, "partition_key_version", 2)
  throughput            = lookup(each.value, "throughput", null)
  default_ttl           = lookup(each.value, "default_ttl", null)

  dynamic "autoscale_settings" {
    for_each = lookup(each.value, "autoscale_settings", null) != null ? [1] : []
    content {
      max_throughput = each.value.autoscale_settings.max_throughput
    }
  }
}
