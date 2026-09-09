resource "azurerm_key_vault_secret" "st_app_primary_connection_string" {
  name         = "st-app-primary-connection-string"
  key_vault_id = module.key_vault_weu.kv_common.id
  value        = module.storage_accounts_weu.app_primary_connection_string

  tags = local.tags
}
