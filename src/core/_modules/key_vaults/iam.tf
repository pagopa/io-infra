module "iam_tlscert_kv_admins" {
  for_each = var.admins

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~>1.3"

  subscription_id = var.subscription_id
  principal_id    = each.value

  key_vault = [{
    name                = azurerm_key_vault.tlscert_itn_01.name
    resource_group_name = azurerm_key_vault.tlscert_itn_01.resource_group_name
    has_rbac_support    = azurerm_key_vault.tlscert_itn_01.enable_rbac_authorization
    description         = "Allows Admin AD Groups to manage the Key Vault"
    roles = {
      secrets      = "owner"
      certificates = "owner"
      keys         = "owner"
    }
  }]
}

module "iam_tlscert_kv_devs" {
  for_each = var.devs

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~>1.3"

  subscription_id = var.subscription_id
  principal_id    = each.value

  key_vault = [{
    name                = azurerm_key_vault.tlscert_itn_01.name
    resource_group_name = azurerm_key_vault.tlscert_itn_01.resource_group_name
    has_rbac_support    = azurerm_key_vault.tlscert_itn_01.enable_rbac_authorization
    description         = "Allows Devs AD Groups to write secrets and keys, while reading certificates stored into the Key Vault"
    roles = {
      secrets      = "writer"
      certificates = "reader"
      keys         = "writer"
    }
  }]
}
