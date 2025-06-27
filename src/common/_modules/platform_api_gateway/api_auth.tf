resource "azurerm_api_management_product" "auth" {
  product_id   = "io-auth"
  display_name = "IO Auth & Identity"
  description  = "Product for IO A&I APIs"

  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false
}

resource "azurerm_api_management_product_policy" "auth" {
  product_id          = azurerm_api_management_product.auth.product_id
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  xml_content = file("${path.module}/policies/auth/product_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "identity_v1" {
  name                = "auth_v1"
  api_management_name = azurerm_api_management_product.auth.api_management_name
  resource_group_name = azurerm_api_management_product.auth.resource_group_name
  display_name        = "Auth & Identity app-backend v1"
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "identity" {
  name                  = format("%s-p-auth-api", var.prefix)
  api_management_name   = module.platform_api_gateway.name
  resource_group_name   = module.platform_api_gateway.resource_group_name
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.identity_v1.id
  version        = "v1"
  revision       = 1

  description  = "IO Auth & Identity app-backend API"
  display_name = "Auth & Identity io-backend"
  path         = "api/identity"
  protocols    = ["https"]

  import {
    content_format = "openapi-link"
    # The commit id refers to the last commit of refactor-openapi-specs branch.
    content_value = "https://raw.githubusercontent.com/pagopa/io-backend/8f7cb251fe1f3875a53b066ee062f4a80d117598/openapi/generated/api_auth.yaml"
  }
}

resource "azurerm_api_management_product_api" "auth_identity" {
  api_name            = azurerm_api_management_api.identity.name
  product_id          = azurerm_api_management_product.auth.product_id
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
}

resource "azurerm_api_management_api_policy" "identity" {
  api_name            = azurerm_api_management_api.identity.name
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  xml_content = file("${path.module}/policies/auth/v1/_base_policy.xml")
}
