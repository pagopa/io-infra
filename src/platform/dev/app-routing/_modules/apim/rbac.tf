module "iam_adgroup_wallet_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_wallet_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_adgroup_com_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_com_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_adgroup_svc_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_svc_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_adgroup_auth_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_auth_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_adgroup_bonus_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_bonus_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}
