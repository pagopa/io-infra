data "azurerm_api_management" "apim" {
  name                = var.apim.name
  resource_group_name = var.apim.resource_group_name
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}

#trivy:ignore:AVD-DX-0001
data "azurerm_key_vault_secret" "cgn_onboarding_backend_identity_v2" {
  name         = "cgn-onboarding-backend-PRINCIPALID"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}
