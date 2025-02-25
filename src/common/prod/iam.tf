locals {
  role_definition_names = {
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

# APIM CLIENT

data "azuread_service_principal" "apim_client_svc" {
  display_name = "io-p-apim-api-management-client"
}

resource "azurerm_role_assignment" "apim_client_role" {
  for_each             = toset(local.role_definition_names.apim_client)
  principal_id         = data.azuread_service_principal.apim_client_svc.object_id
  role_definition_name = each.value
  scope                = module.apim_itn.id
}

# DEVELOPER PORTAL

data "azuread_service_principal" "dev_portal_svc" {
  display_name = "io-prod-sp-developer-portal"
}

resource "azurerm_role_assignment" "dev_portal_role" {
  for_each             = toset(local.role_definition_names.dev_portal)
  principal_id         = data.azuread_service_principal.dev_portal_svc.object_id
  role_definition_name = each.value
  scope                = module.apim_itn.id
}

# Dev Team

resource "azurerm_role_assignment" "svc_devs_weu" {
  principal_id         = data.azuread_group.svc_devs.object_id
  role_definition_name = "PagoPA API Management Operator App"
  scope                = module.apim_weu.id
}

resource "azurerm_role_assignment" "svc_devs_itn" {
  principal_id         = data.azuread_group.svc_devs.object_id
  role_definition_name = "PagoPA API Management Operator App"
  scope                = module.apim_itn.id
}
