#
# LolliPOP containers
#
resource "azurerm_cosmosdb_sql_container" "lollipop_thumbprints" {

  name                = "lollipop-thumbprints"
  resource_group_name = data.azurerm_cosmosdb_account.cosmos_api.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.cosmos_api.name
  database_name       = data.azurerm_cosmosdb_sql_database.db.name

  partition_key_path    = "/thumbprintId"
  partition_key_version = 2

  dynamic "autoscale_settings" {
      max_throughput = 10000
  }

  default_ttl = -1

}