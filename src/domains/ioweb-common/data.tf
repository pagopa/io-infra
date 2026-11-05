#
# MANAGED IDENTITIES
#

data "azurerm_user_assigned_identity" "managed_identity_io_infra_ci" {
  name                = "${local.product}-infra-github-ci-identity"
  resource_group_name = "${local.product}-identity-rg"
}

data "azurerm_user_assigned_identity" "managed_identity_io_infra_cd" {
  name                = "${local.product}-infra-github-cd-identity"
  resource_group_name = "${local.product}-identity-rg"
}

data "azurerm_user_assigned_identity" "managed_identity_auth_n_identity_infra_ci" {
  name                = "${local.product}-itn-auth-infra-github-ci-id-01"
  resource_group_name = "${local.product}-itn-auth-rg-01"
}

data "azurerm_user_assigned_identity" "managed_identity_auth_n_identity_infra_cd" {
  name                = "${local.product}-itn-auth-infra-github-cd-id-01"
  resource_group_name = "${local.product}-itn-auth-rg-01"
}

data "terraform_remote_state" "platform_observability" {
  backend = "azurerm"

  config = {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "iopitntfst001"
    container_name       = "terraform-state"
    key                  = "io-infra.platform.observability.prod.tfstate"
    use_azuread_auth     = true
  }
}

########
# APIM #
########

# APIM in ITN
data "azurerm_api_management" "apim_itn_api" {
  name                = local.apim_itn_name
  resource_group_name = local.apim_itn_resource_group_name
}
