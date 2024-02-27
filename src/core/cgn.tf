data "azurerm_resource_group" "rg_cgn" {
  name = format("%s-rg-cgn", local.project)
}

data "azurerm_storage_account" "iopstcgn" {
  name                = "iopstcgn"
  resource_group_name = data.azurerm_resource_group.rg_cgn.name
}

locals {
  cgn_app_registreation_name = "cgn-onboarding-portal-backend"
}

### cgnonboardingportal user identity
data "azurerm_key_vault_secret" "cgn_onboarding_backend_identity" {
  name         = "cgn-onboarding-backend-PRINCIPALID"
  key_vault_id = module.key_vault_common.id
}


