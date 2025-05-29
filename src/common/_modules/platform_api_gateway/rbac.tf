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
      role                = "writer"
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
      role                = "writer"
    }
  ]
}
