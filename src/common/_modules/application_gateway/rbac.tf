## user assined identity: (application gateway) ##
resource "azurerm_user_assigned_identity" "appgateway" {
  resource_group_name = var.resource_groups.sec
  location            = var.location
  name                = format("%s-appgateway-identity", var.project)

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "app_gateway_policy" {
  key_vault_id            = var.key_vault.id
  tenant_id               = var.datasources.azurerm_client_config.tenant_id
  object_id               = azurerm_user_assigned_identity.appgateway.principal_id
  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "app_gateway_policy_common" {
  key_vault_id            = var.key_vault_common.id
  tenant_id               = var.datasources.azurerm_client_config.tenant_id
  object_id               = azurerm_user_assigned_identity.appgateway.principal_id
  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

resource "azurerm_key_vault_access_policy" "app_gateway_policy_ioweb" {
  key_vault_id            = data.azurerm_key_vault.ioweb_kv.id
  tenant_id               = var.datasources.azurerm_client_config.tenant_id
  object_id               = azurerm_user_assigned_identity.appgateway.principal_id
  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

## user assined identity: (old application gateway) ##
resource "azurerm_key_vault_access_policy" "app_gw_uai_kvreader_common" {
  key_vault_id            = var.key_vault_common.id
  tenant_id               = var.datasources.azurerm_client_config.tenant_id
  object_id               = data.azuread_service_principal.app_gw_uai_kvreader.object_id
  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}