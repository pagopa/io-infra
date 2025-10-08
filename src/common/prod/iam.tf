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
resource "azurerm_role_assignment" "svc_devs_itn" {
  principal_id         = data.azuread_group.svc_devs.object_id
  role_definition_name = "PagoPA API Management Operator App"
  scope                = module.apim_itn.id
}

resource "azurerm_key_vault_access_policy" "itn_kv_common_infra_ci" {
  key_vault_id = data.azurerm_key_vault.itn_key_vault.id
  object_id    = data.azurerm_user_assigned_identity.managed_identity_io_infra_ci.principal_id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  key_permissions         = ["Get", "List"]
}

resource "azurerm_key_vault_access_policy" "itn_kv_common_infra_cd" {
  key_vault_id = data.azurerm_key_vault.itn_key_vault.id
  object_id    = data.azurerm_user_assigned_identity.managed_identity_io_infra_cd.principal_id
  tenant_id    = data.azurerm_client_config.current.tenant_id

  secret_permissions      = ["Get", "List", "Delete", "Set"]
  certificate_permissions = ["Get", "List"]
  key_permissions         = ["Get", "List"]
}
