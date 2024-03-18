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

# TODO rollback after apim-v2 migration
# resource "azurerm_role_assignment" "service_contributor" {
#   count                = var.env_short == "p" ? 1 : 0
#   scope                = module.apim.id
#   role_definition_name = "API Management Service Contributor"
#   principal_id         = data.azurerm_key_vault_secret.cgn_onboarding_backend_identity.value
# }

data "azurerm_resource_group" "cgn_be_rg" {
  name = format("%s-cgn-be-rg", local.project)
}

resource "azurerm_app_service_plan" "cgn_common" {
  name                = format("%s-plan-cgn-common", local.project)
  location            = data.azurerm_resource_group.cgn_be_rg.location
  resource_group_name = data.azurerm_resource_group.cgn_be_rg.name

  kind     = var.plan_cgn_kind
  reserved = true

  sku {
    tier     = var.plan_cgn_sku_tier
    size     = var.plan_cgn_sku_size
    capacity = var.plan_cgn_sku_capacity
  }

  tags = var.tags
}

data "azurerm_subnet" "cgn_snet" {
  name                 = format("%s-cgn-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = module.vnet_common.name
}
