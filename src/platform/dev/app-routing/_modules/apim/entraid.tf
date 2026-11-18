data "azuread_application" "test_apim_api" {
  display_name = "${var.prefix}-d-test-apim-entraid-01"
}

data "azuread_service_principal" "test_apim_api" {
  client_id = data.azuread_application.test_apim_api.client_id
}

removed {
  from = azuread_application.test_apim_api

  lifecycle {
    destroy = false
  }
}

removed {
  from = azuread_service_principal.test_apim_api

  lifecycle {
    destroy = false
  }
}