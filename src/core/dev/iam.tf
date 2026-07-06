resource "azurerm_key_vault_access_policy" "kv_common_infra_ci" {
  key_vault_id = data.azurerm_key_vault.itn_common.id
  object_id    = data.azurerm_user_assigned_identity.managed_identity_io_infra_ci.principal_id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  key_permissions         = ["Get", "List"]
}

resource "azurerm_key_vault_access_policy" "kv_common_infra_cd" {
  key_vault_id = data.azurerm_key_vault.itn_common.id
  object_id    = data.azurerm_user_assigned_identity.managed_identity_io_infra_cd.principal_id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  secret_permissions      = ["Get", "List", "Delete", "Set"]
  certificate_permissions = ["Get", "List"]
  key_permissions         = ["Get", "List"]
}