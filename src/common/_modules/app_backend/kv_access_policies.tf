resource "azurerm_key_vault_access_policy" "app_backend_kv_common" {
  key_vault_id = var.key_vault_common.id
  tenant_id    = var.datasources.azurerm_client_config.tenant_id
  object_id    = module.appservice_app_backend.principal_id

  secret_permissions      = ["Get", "List"]
  certificate_permissions = []
  key_permissions         = []
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "appservice_app_backend_slot_staging_kv_common" {
  key_vault_id = var.key_vault_common.id
  tenant_id    = var.datasources.azurerm_client_config.tenant_id
  object_id    = module.appservice_app_backend.principal_id

  secret_permissions      = ["Get", "List"]
  certificate_permissions = []
  key_permissions         = []
  storage_permissions     = []
}
