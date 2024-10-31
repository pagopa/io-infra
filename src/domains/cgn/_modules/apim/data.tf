# APIM in WEU
data "azurerm_api_management" "apim" {
  name                = local.apim_v2_name
  resource_group_name = local.apim_resource_group_name
}

# APIM in ITN
data "azurerm_api_management" "apim_itn" {
  name                = local.apim_itn_name
  resource_group_name = local.apim_itn_resource_group_name
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_key_vault_secret" "cgnonboardingportal_os_key" {
  name         = "funccgn-KEY-CGNOS"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "cgnonboardingportal_os_header_name" {
  name         = "funccgn-KEY-CGNOSHEADERNAME"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "io_fn_cgnmerchant_key_secret_v2" {
  name         = "io-fn-cgnmerchant-KEY-APIM"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "cgn_onboarding_backend_identity_v2" {
  name         = "cgn-onboarding-backend-PRINCIPALID"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}
