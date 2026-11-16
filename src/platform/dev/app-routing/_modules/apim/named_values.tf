resource "azurerm_api_management_named_value" "entra_tenant_id" {
  name                = "entra-tenant-id"
  display_name        = "entra-tenant-id"
  resource_group_name = module.apim.resource_group_name
  api_management_name = module.apim.name

  value  = var.datasources.azurerm_client_config.tenant_id
  secret = false
}

resource "azurerm_api_management_named_value" "test_api_client_id" {
  name                = "test-api-client-id"
  display_name        = "test-api-client-id"
  resource_group_name = module.apim.resource_group_name
  api_management_name = module.apim.name

  value  = data.azuread_application.test_apim_api.client_id
  secret = false
}