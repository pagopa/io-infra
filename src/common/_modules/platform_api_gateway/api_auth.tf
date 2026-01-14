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
