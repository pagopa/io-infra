provider "azurerm" {
  alias           = "prod-esercenti"
  subscription_id = "74da48a3-b0e7-489d-8172-da79801086ed"

  features {}
}

locals {
  role_definition_names = {
    cgn = [
      "Reader",
      "API Management Service Reader Role",
      "API Management Service Contributor"
    ]
    apim_client = [
      "Reader",
      "API Management Service Reader Role",
      "Contributor"
    ]
    dev_portal = [
      "Reader",
      "API Management Service Reader Role",
      "Contributor"
    ]
  }
}

# CGN

data "azurerm_linux_web_app" "portal_backend_1" {
  provider            = azurerm.prod-esercenti
  name                = "cgnonboardingportal-p-portal-backend1"
  resource_group_name = "cgnonboardingportal-p-api-rg"
}

resource "azurerm_role_assignment" "cgn_backend1_role" {
  for_each             = toset(local.role_definition_names.cgn)
  principal_id         = data.azurerm_linux_web_app.portal_backend_1.identity[0].principal_id
  role_definition_name = each.value
  scope                = module.apim_itn.id
}

# APIM CLIENT

data "azuread_service_principal" "apim_client_svc" {
  display_name = "io-p-apim-api-management-client"
}

resource "azurerm_role_assignment" "apim_client_role" {
  for_each             = toset(local.role_definition_names.apim_client)
  principal_id         = data.azuread_service_principal.apim_client_svc.id
  role_definition_name = each.value
  scope                = module.apim_itn.id
}

# DEVELOPER PORTAL

data "azuread_service_principal" "dev_portal_svc" {
  display_name = "io-prod-sp-developer-portal"
}

resource "azurerm_role_assignment" "dev_portal_role" {
  for_each             = toset(local.role_definition_names.dev_portal)
  principal_id         = data.azuread_service_principal.dev_portal_svc.id
  role_definition_name = each.value
  scope                = module.apim_itn.id
}
