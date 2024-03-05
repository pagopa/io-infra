resource "azurerm_role_assignment" "service_contributor_v2" {
  scope                = data.azurerm_api_management.apim.id
  role_definition_name = "API Management Service Contributor"
  principal_id         = data.azurerm_key_vault_secret.cgn_onboarding_backend_identity_v2.value
}
