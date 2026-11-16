resource "random_uuid" "role_read_id" {}
resource "random_uuid" "role_write_id" {}

resource "azuread_application" "test_apim_api" {
  display_name     = "${var.prefix}-d-test-apim-entraid-01"
  sign_in_audience = "AzureADMyOrg"
  identifier_uris = [
    "api://${var.datasources.azurerm_client_config.tenant_id}/test-apim"
  ]

  api {
    requested_access_token_version = 2
  }
  app_role {
    allowed_member_types = ["Application"]
    description          = "Allow to retrieve reading access to data"
    display_name         = "ApiRead"
    enabled              = true
    id                   = random_uuid.role_read_id.result
    value                = "ApiRead"
  }
  app_role {
    allowed_member_types = ["Application"]
    description          = "Allow to create data"
    display_name         = "ApiWrite"
    enabled              = true
    id                   = random_uuid.role_write_id.result
    value                = "ApiWrite"
  }
}

resource "azuread_service_principal" "test_apim_api" {
  client_id                    = azuread_application.test_apim_api.client_id
  app_role_assignment_required = true
}