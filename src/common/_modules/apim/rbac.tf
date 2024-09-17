resource "azurerm_key_vault_access_policy" "apim_v2_kv_policy" {
  key_vault_id = var.key_vault.id
  tenant_id    = var.datasources.azurerm_client_config.tenant_id
  object_id    = module.apim_v2.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "v2_common" {
  key_vault_id = var.key_vault_common.id
  tenant_id    = var.datasources.azurerm_client_config.tenant_id
  object_id    = module.apim_v2.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}
