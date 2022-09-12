data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.product)
  resource_group_name = format("%s-rg-internal", local.product)
}

resource "azurerm_key_vault_secret" "cosmos_api_master_key" {
  name         = "${data.azurerm_cosmosdb_account.cosmos_api.name}-master-key"
  value        = data.azurerm_cosmosdb_account.cosmos_api.primary_master_key
  content_type = "text/plain"

  key_vault_id = module.key_vault.id
}