data "azurerm_api_management" "apim" {
  name                = format("%s-apim-api", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

# ## api management key vault policy ##
resource "azurerm_key_vault_access_policy" "kv" {
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_api_management.apim.identity[0].principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "common" {
  key_vault_id = data.azurerm_key_vault.common.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_api_management.apim.identity[0].principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}
