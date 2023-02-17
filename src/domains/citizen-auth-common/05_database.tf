data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.product)
  resource_group_name = format("%s-rg-internal", local.product)
}

data "azurerm_cosmosdb_sql_database" "db" {
  name                = "db"
  resource_group_name = data.azurerm_cosmosdb_account.cosmos_api.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.cosmos_api.name
}

#
# LolliPOP containers
#
resource "azurerm_cosmosdb_sql_container" "lollipop_pubkeys" {

  name                = "lollipop-pubkeys"
  resource_group_name = data.azurerm_cosmosdb_account.cosmos_api.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.cosmos_api.name
  database_name       = data.azurerm_cosmosdb_sql_database.db.name

  partition_key_path    = "/assertionRef"
  partition_key_version = 2

  dynamic "autoscale_settings" {
    for_each = [""]
    content {
      max_throughput = 1000
    }
  }

  lifecycle {
    ignore_changes = [
      autoscale_settings
    ]
  }

  default_ttl = -1

}