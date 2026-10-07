module "iam_kv_common_infra_ci" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~>1.3"

  subscription_id = data.azurerm_subscription.current.subscription_id
  principal_id    = data.azurerm_user_assigned_identity.managed_identity_io_infra_ci.principal_id

  key_vault = [{
    name                = data.azurerm_key_vault.itn_common.name
    resource_group_name = "io-d-itn-common-rg-01" # TODO: change RG name after importing it in the DEV environment
    has_rbac_support    = true
    description         = "Allow the io-d-infra-github-ci-identity to read all values"
    roles = {
      secrets      = "reader"
      certificates = "reader"
      keys         = "reader"
    }
  }]
}

module "iam_kv_common_infra_cd" {

  source  = "pagopa-dx/azure-role-assignments/azurerm"
  version = "~>1.3"

  subscription_id = data.azurerm_subscription.current.subscription_id
  principal_id    = data.azurerm_user_assigned_identity.managed_identity_io_infra_ci.principal_id

  key_vault = [{
    name                = data.azurerm_key_vault.itn_common.name
    resource_group_name = "io-d-itn-common-rg-01" # TODO: change RG name after importing it in the DEV environment
    has_rbac_support    = true
    description         = "Allow the io-d-infra-github-cd-identity to write all values"
    roles = {
      secrets      = "writer"
      certificates = "writer"
      keys         = "writer"
    }
  }]
}
