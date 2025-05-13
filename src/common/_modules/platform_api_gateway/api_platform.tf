resource "azurerm_api_management_product" "platform_apim_product" {
  product_id   = "io-platform"
  display_name = "IO PLATFORM"
  description  = "Product for IO Platform APIs"

  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false
}

resource "azurerm_api_management_product_policy" "platform_apim_product_policy" {
  product_id          = azurerm_api_management_product.platform_apim_product.product_id
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  xml_content = file("${path.module}/apis/base_policy.xml")
}

resource "azurerm_api_management_group" "platform_apim_group" {
  name                = "platform"
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
  display_name        = "Platform APIM Product Owners"
  description         = "Owners of io-platform product with management rights"
  type                = "external"
  external_id         = "aad://${var.azure_adgroup_platform_admins_object_id}"
}

resource "azurerm_api_management_product_group" "platform_apim_product_group" {
  product_id          = azurerm_api_management_product.platform_apim_product.product_id
  group_name          = azurerm_api_management_group.platform_apim_group.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
}

data "http" "platform_app_backend_openapi" {
  # TODO: update this URL with master branch when the new openapi spec will be released
  url = "https://raw.githubusercontent.com/pagopa/io-backend/refs/heads/refactor-openapi-specs/openapi/generated/api_platform.yaml"
}

resource "azurerm_api_management_api" "platform_app_backend_api" {
  name                  = format("%s-p-app-backend-platform-api", var.prefix)
  api_management_name   = module.platform_api_gateway.name
  resource_group_name   = module.platform_api_gateway.resource_group_name
  subscription_required = false

  revision = 1

  description  = "IO Platform app-backend API"
  display_name = "Platform app-backend"
  path         = ""
  protocols    = ["https"]

  import {
    content_format = "openapi"
    content_value  = data.http.platform_app_backend_openapi.body
  }
}

resource "azurerm_api_management_product_api" "platform_api_product_link" {
  api_name            = azurerm_api_management_api.platform_app_backend_api.name
  product_id          = azurerm_api_management_product.platform_apim_product.product_id
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
}

resource "azurerm_api_management_api_policy" "platform_app_backend_api_policy" {
  api_name            = azurerm_api_management_api.platform_app_backend_api.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  xml_content = file("${path.module}/apis/platform/_base_policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "get_services_status_operation_policy" {
  depends_on = [
    azurerm_api_management_api.platform_app_backend_api
  ]

  api_name            = azurerm_api_management_api.platform_app_backend_api.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
  operation_id        = "getServicesStatus"
  xml_content         = file("${path.module}/apis/platform/v1/get_services_status_policy.xml")
}
