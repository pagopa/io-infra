data "azurerm_api_management" "apim" {
  name                = var.apim.name
  resource_group_name = var.apim.resource_group_name
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

data "azurerm_key_vault_secret" "io_fn_cgn_support_key" {
  name         = "io-fn-cgn-support-KEY-APIM"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "io_fn_cgn_card_key" {
  name         = "io-fn-cgn-card-KEY-APIM"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "cgn_onboarding_backend_identity_v2" {
  name         = "cgn-onboarding-backend-PRINCIPALID"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}
