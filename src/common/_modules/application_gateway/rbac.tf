## user assined identity: (application gateway) ##
resource "azurerm_user_assigned_identity" "appgateway" {
  resource_group_name = var.resource_group_security
  location            = var.location
  name                = try(local.nonstandard[var.location_short].id, "${var.project}-agw-id-01")

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

//TODO: add permissions (RBAC) to new IOWEB KV

module "app_gw_ioweb_kv" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.1"

  subscription_id = var.subscription_id
  principal_id    = azurerm_user_assigned_identity.appgateway.principal_id

  key_vault = [
    {
      name                = var.ioweb_kv.name
      resource_group_name = var.ioweb_kv.resource_group_name
      has_rbac_support    = true
      description         = "Allow certificate read access to the Application Gateway identity on the IOWeb Key Vault"
      roles = {
        certificates = "reader"
      }
    }
  ]
}
