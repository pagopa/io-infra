/*
module "iam_adgroup_admins" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_admins_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_adgroup_developers" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_developers_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}

module "iam_adgroup_externals" {
  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 0.0"

  principal_id = var.azure_adgroup_externals_object_id

  apim = [
    {
      name                = module.apim.name
      resource_group_name = module.apim.resource_group_name
      role                = "owner"
    }
  ]
}
*/