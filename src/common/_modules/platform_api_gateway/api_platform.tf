resource "azurerm_api_management_product" "platform" {
  product_id   = "io-platform"
  display_name = "IO PLATFORM"
  description  = "Product for IO Platform APIs"

  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false
}

resource "azurerm_api_management_product_policy" "platform" {
  product_id          = azurerm_api_management_product.platform.product_id
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  xml_content = file("${path.module}/policies/platform/product_base_policy.xml")
}

resource "azurerm_api_management_api" "platform_legacy" {
  name                  = format("%s-p-platform-legacy-api", var.prefix)
  api_management_name   = module.platform_api_gateway.name
  resource_group_name   = module.platform_api_gateway.resource_group_name
  subscription_required = false

  revision = 1

  description  = "IO Platform app-backend API"
  display_name = "Platform app-backend"
  path         = "api/platform-legacy"
  protocols    = ["https"]

  import {
    content_format = "openapi-link"
    # The commit id refers to the last commit of refactor-openapi-specs branch.
    content_value = "https://raw.githubusercontent.com/pagopa/io-backend/9e5e8ab6ee8ea67c4b8c50e02a1da4862c33ccf2/openapi/generated/api_platform_legacy.yaml"
  }
}

resource "azurerm_api_management_product_api" "platform_platform_legacy" {
  api_name            = azurerm_api_management_api.platform_legacy.name
  product_id          = azurerm_api_management_product.platform.product_id
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
}

resource "azurerm_api_management_api_policy" "platform_legacy" {
  api_name            = azurerm_api_management_api.platform_legacy.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  xml_content = file("${path.module}/policies/platform/v1/_base_policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "platform_legacy_get_services_status" {
  api_name            = azurerm_api_management_api.platform_legacy.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
  operation_id        = "getServicesStatus"
  xml_content         = file("${path.module}/policies/platform/v1/get_services_status/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "platform_legacy_get_services_status_head" {
  api_name            = azurerm_api_management_api.platform_legacy.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
  operation_id        = "getServicesStatusHead"
  xml_content         = file("${path.module}/policies/platform/v1/get_services_status_head/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "platform_legacy_get_ping" {
  api_name            = azurerm_api_management_api.platform_legacy.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
  operation_id        = "getPing"
  xml_content         = file("${path.module}/policies/platform/v1/get_ping/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "platform_legacy_get_ping_head" {
  api_name            = azurerm_api_management_api.platform_legacy.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
  operation_id        = "getPing"
  xml_content         = file("${path.module}/policies/platform/v1/get_ping_head/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "platform_legacy_get_server_info" {
  api_name            = azurerm_api_management_api.platform_legacy.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
  operation_id        = "getServerInfo"
  xml_content         = file("${path.module}/policies/platform/v1/get_server_info/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "platform_legacy_redirect" {
  api_name            = azurerm_api_management_api.platform_legacy.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
  operation_id        = "Redirect"
  xml_content         = file("${path.module}/policies/platform/v1/redirect/policy.xml")
}
