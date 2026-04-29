locals {
  session_managers_ids = [
    module.session_manager_weu.principal_id,
    module.session_manager_weu_staging.principal_id,
    module.session_manager_weu_bis.principal_id,
    module.session_manager_weu_bis_staging.principal_id,
  ]
}

resource "azurerm_key_vault_access_policy" "kv_common" {
  for_each = toset(local.session_managers_ids)

  key_vault_id = data.azurerm_key_vault.kv_common.id
  tenant_id    = data.azurerm_subscription.current.tenant_id
  object_id    = each.value

  secret_permissions      = ["Get", "List"]
  certificate_permissions = []
  key_permissions         = []
  storage_permissions     = []
}

module "session_manager_weu_role_assignments" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~>1.2.1"

  for_each = toset(local.session_managers_ids)

  principal_id    = each.value
  subscription_id = data.azurerm_subscription.current.subscription_id

  key_vault = [
    {
      name                = data.azurerm_key_vault.auth.name
      resource_group_name = data.azurerm_key_vault.auth.resource_group_name
      description         = "Allow session_manager_weu to read secrets from key vault"
      roles = {
        secrets = "reader"
      }
    }
  ]
}
