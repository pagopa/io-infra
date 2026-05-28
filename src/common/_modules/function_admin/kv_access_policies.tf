resource "azurerm_key_vault_access_policy" "function_admin_itn_kv_common" {
  key_vault_id = data.azurerm_key_vault.common.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.function_admin_itn.function_app.function_app.principal_id

  secret_permissions      = ["Get", "List"]
  certificate_permissions = []
  key_permissions         = []
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "function_admin_itn_slot_staging_kv_common" {
  key_vault_id = data.azurerm_key_vault.common.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.function_admin_itn.function_app.function_app.slot.principal_id

  secret_permissions      = ["Get", "List"]
  certificate_permissions = []
  key_permissions         = []
  storage_permissions     = []
}
