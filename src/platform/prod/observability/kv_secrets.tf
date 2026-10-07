resource "azurerm_key_vault_secret" "st_logs_primary_connection_string" {
  name         = "st-logs-primary-connection-string"
  key_vault_id = local.core.key_vault.weu.kv_common.id
  value        = module.storage_accounts_westeurope.logs.westeurope.primary_connection_string

  tags = local.tags
}
