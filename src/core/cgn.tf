data "azurerm_resource_group" "rg_cgn" {
  name = format("%s-rg-cgn", local.project)
}

locals {
  cgn_app_registreation_name = "cgn-onboarding-portal-backend"
}

### cgnonboardingportal user identity
data "azurerm_key_vault_secret" "cgn_onboarding_backend_identity" {
  name         = "cgn-onboarding-backend-PRINCIPALID"
  key_vault_id = module.key_vault_common.id
}


