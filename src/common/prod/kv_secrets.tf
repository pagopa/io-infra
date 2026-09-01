resource "azurerm_key_vault_secret" "st_app_primary_connection_string" {
  name         = "st-app-primary-connection-string"
  key_vault_id = local.core.key_vault.weu.kv_common.id
  value        = module.storage_accounts.app_primary_connection_string

  tags = local.tags
}

resource "azurerm_key_vault_secret" "st_logs_primary_connection_string" {
  name         = "st-logs-primary-connection-string"
  key_vault_id = local.core.key_vault.weu.kv_common.id
  value        = module.storage_accounts.logs_primary_connection_string

  tags = local.tags
}
