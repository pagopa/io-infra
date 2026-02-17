resource "azurerm_key_vault_access_policy" "platform_api_gateway_kv_policy" {
  key_vault_id = var.key_vault.id
  tenant_id    = var.datasources.azurerm_client_config.tenant_id
  object_id    = module.platform_api_gateway.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

module "iam_adgroup" {
  for_each = {
    for assignment in local.apim_adgroup_rbac :
    assignment.principal_id => assignment
  }
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  principal_id    = each.value.principal_id
  subscription_id = data.azurerm_client_config.current.subscription_id

  apim = [
    {
      name                = module.platform_api_gateway.name
      resource_group_name = module.platform_api_gateway.resource_group_name
      description         = each.value.description
      role                = each.value.role
    }
  ]
}

moved {
  from = module.iam_adgroup_product_admins
  to   = module.iam_adgroup["a0ed72be-f9f9-407e-bf25-91761f8d3de7"]
}

moved {
  from = module.iam_adgroup_bonus_admins
  to   = module.iam_adgroup["831e5214-2f68-4a13-b25f-7bec962c7e1b"]
}

moved {
  from = module.iam_adgroup_bonus_infra_cd
  to   = module.iam_adgroup["ef6b556d-4d33-4467-ad9d-6b5540cbde6b"]
}
