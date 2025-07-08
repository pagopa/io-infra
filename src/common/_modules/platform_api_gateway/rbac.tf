resource "azurerm_key_vault_access_policy" "platform_api_gateway_kv_policy" {
  key_vault_id = var.key_vault.id
  tenant_id    = var.datasources.azurerm_client_config.tenant_id
  object_id    = module.platform_api_gateway.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

# Typo: this module should be renamed to `iam_adgroup_platform_admins`
module "iam_adgroup_product_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  principal_id    = var.azure_adgroup_platform_admins_object_id
  subscription_id = data.azurerm_client_config.current.subscription_id

  apim = [
    {
      name                = module.platform_api_gateway.name
      resource_group_name = module.platform_api_gateway.resource_group_name
      description         = "Platform team admin group"
      role                = "owner"
    }
  ]
}

locals {
  apim_adgroup_rbac = [
    {
      principal_id = var.azure_adgroup_auth_admins_object_id
      description  = "Auth & Identity team admin group"
      role         = "owner"
    },
    {
      principal_id = var.azure_user_assigned_identity_auth_infra_cd
      description  = "Auth & Identity team infra CD identity"
      role         = "owner"
    }
  ]

  apim_adgroup_rbac_map = {
    for assignment in local.apim_adgroup_rbac :
    assignment.principal_id => assignment
  }
}

module "iam_adgroup" {
  for_each = local.apim_adgroup_rbac_map
  source   = "pagopa-dx/azure-role-assignments/azurerm"
  version  = "~> 1.0"

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

module "iam_adgroup_bonus_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  principal_id    = var.azure_adgroup_bonus_admins_object_id
  subscription_id = data.azurerm_client_config.current.subscription_id

  apim = [
    {
      name                = module.platform_api_gateway.name
      resource_group_name = module.platform_api_gateway.resource_group_name
      description         = "Bonus team admin group"
      role                = "owner"
    }
  ]
}

module "iam_adgroup_bonus_infra_cd" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 1.0"

  principal_id    = var.azure_user_assigned_identity_bonus_infra_cd
  subscription_id = data.azurerm_client_config.current.subscription_id

  apim = [
    {
      name                = module.platform_api_gateway.name
      resource_group_name = module.platform_api_gateway.resource_group_name
      description         = "Bonus team infra CD identity"
      role                = "owner"
    }
  ]
}
