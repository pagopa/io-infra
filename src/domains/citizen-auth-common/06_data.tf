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
  name                = "${local.product}-auth-github-ci-identity"
  resource_group_name = "${local.product}-identity-rg"
}

data "azurerm_user_assigned_identity" "managed_identity_auth_n_identity_infra_cd" {
  name                = "${local.product}-auth-github-cd-identity"
  resource_group_name = "${local.product}-identity-rg"
}


# ITN LOLLIPOP FUNCTION
data "azurerm_resource_group" "lollipop_function_rg" {
  name = format("%s-auth-lollipop-rg-02", local.common_project_itn)
}

data "azurerm_linux_function_app" "lollipop_function" {
  name                = format("%s-auth-lollipop-func-02", local.common_project_itn)
  resource_group_name = data.azurerm_resource_group.lollipop_function_rg.name
}
#######################

########
# APIM #
########

# APIM in ITN
data "azurerm_api_management" "apim_itn_api" {
  name                = local.apim_itn_name
  resource_group_name = local.apim_itn_resource_group_name
}

# For Named Value fn-lollipop
data "azurerm_key_vault_secret" "io_fn_itn_lollipop_key_secret_v2" {
  name         = "io-fn-itn-lollipop-KEY-APIM"
  key_vault_id = module.key_vault.id
}

# For APIM API module apim_v2_fast_login_operation_api_v1
data "azurerm_linux_function_app" "functions_fast_login" {
  name                = local.fn_fast_login_name
  resource_group_name = local.fn_fast_login_resource_group_name
}

# For Named Value fn-fast-login
data "azurerm_key_vault_secret" "functions_fast_login_api_key" {
  name         = "io-fn-weu-fast-login-KEY-APIM"
  key_vault_id = module.key_vault.id
}
