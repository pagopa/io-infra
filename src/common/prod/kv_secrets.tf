resource "azurerm_key_vault_secret" "cosmos_api_connection_string" {
  name         = "cosmos-api-connection-string"
  key_vault_id = local.core.key_vault.weu.kv_common.id
  value        = module.cosmos_api_weu.connection_string

  tags = local.tags
}

resource "azurerm_key_vault_secret" "cosmos_api_primary_key" {
  name         = "cosmos-api-primary-key"
  key_vault_id = local.core.key_vault.weu.kv_common.id
  value        = module.cosmos_api_weu.primary_key

  tags = local.tags
}

resource "azurerm_key_vault_secret" "st_app_primary_connection_string" {
  name         = "st-app-primary-connection-string"
  key_vault_id = local.core.key_vault.weu.kv_common.id
  value        = module.storage_accounts.app_primary_connection_string

  tags = local.tags
}
