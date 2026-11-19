resource "azurerm_api_management_api" "test" {
  name                  = "test-apim"
  resource_group_name   = module.apim.resource_group_name
  api_management_name   = module.apim.name
  revision              = "1"
  display_name          = "Entra ID test API"
  path                  = "test-apim"
  protocols             = ["https"]
  subscription_required = false
}

resource "azurerm_api_management_api_policy" "test" {
  api_name            = azurerm_api_management_api.test.name
  resource_group_name = module.apim.resource_group_name
  api_management_name = module.apim.name
  xml_content         = file("${path.module}/api/test-apim.xml")

  depends_on = [
    azurerm_api_management_named_value.entra_tenant_id,
    azurerm_api_management_named_value.test_api_client_id,
  ]
}

resource "azurerm_api_management_api_operation" "test_get_items" {
  operation_id        = "get-items"
  api_name            = azurerm_api_management_api.test.name
  resource_group_name = module.apim.resource_group_name
  api_management_name = module.apim.name
  display_name        = "Get test items"
  method              = "GET"
  url_template        = "/items"

  response {
    status_code = 200
  }

  response {
    status_code = 401
  }

  response {
    status_code = 403
  }

  depends_on = [azurerm_api_management_api_policy.test]
}

resource "azurerm_api_management_api_operation_policy" "test_get_items" {
  operation_id        = azurerm_api_management_api_operation.test_get_items.operation_id
  api_name            = azurerm_api_management_api.test.name
  resource_group_name = module.apim.resource_group_name
  api_management_name = module.apim.name
  xml_content         = file("${path.module}/api/policies/test-apim/get-items.xml")
}

resource "azurerm_api_management_api_operation" "test_post_items" {
  operation_id        = "post-items"
  api_name            = azurerm_api_management_api.test.name
  resource_group_name = module.apim.resource_group_name
  api_management_name = module.apim.name
  display_name        = "Simulate writing a test item"
  method              = "POST"
  url_template        = "/items"

  response {
    status_code = 200
  }

  response {
    status_code = 401
  }

  response {
    status_code = 403
  }

  depends_on = [azurerm_api_management_api_policy.test]
}

resource "azurerm_api_management_api_operation_policy" "test_post_items" {
  operation_id        = azurerm_api_management_api_operation.test_post_items.operation_id
  api_name            = azurerm_api_management_api.test.name
  resource_group_name = module.apim.resource_group_name
  api_management_name = module.apim.name
  xml_content         = file("${path.module}/api/policies/test-apim/post-items.xml")
}
