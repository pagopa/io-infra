module "iam_apim_itn_infra_ci" {

  depends_on = [module.apim_itn]

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 2.0"

  subscription_id = data.azurerm_subscription.current.subscription_id
  principal_id    = data.azurerm_user_assigned_identity.managed_identity_io_infra_ci.principal_id

  apim = [{
    name                = module.apim_itn.name
    resource_group_name = azurerm_resource_group.apim.name
    has_rbac_support    = true
    description         = "Allow the io-d-infra-github-ci-identity to write all values"
    role                = "owner" # Write necessary to read all the APIM associated secrets
  }]
}

module "iam_apim_itn_infra_cd" {

  depends_on = [module.apim_itn]

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~> 2.0"

  subscription_id = data.azurerm_subscription.current.subscription_id
  principal_id    = data.azurerm_user_assigned_identity.managed_identity_io_infra_cd.principal_id

  apim = [{
    name                = module.apim_itn.name
    resource_group_name = azurerm_resource_group.apim.name
    has_rbac_support    = true
    description         = "Allow the io-d-infra-github-cd-identity to write all values"
    role                = "owner"
  }]
}
