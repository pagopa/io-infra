#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_access_key" {
  name         = "cgn-legalbackup-storage-access-key"
  value        = module.cgn_legalbackup_storage.primary_access_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_connection_string" {
  name         = "cgn-legalbackup-storage-connection-string"
  value        = module.cgn_legalbackup_storage.primary_connection_string
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry
resource "azurerm_key_vault_secret" "cgn_legalbackup_storage_blob_connection_string" {
  name         = "cgn-legalbackup-storage-blob-connection-string"
  value        = module.cgn_legalbackup_storage.primary_blob_connection_string
  content_type = "text/plain"

  key_vault_id = module.key_vault_common.id
}
