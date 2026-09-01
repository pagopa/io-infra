resource "azurerm_api_management_product" "institutions" {
  product_id   = "io-institutions"
  display_name = "IO Institutions"
  description  = "Product for IO Institutions APIs"

  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false
}

resource "azurerm_api_management_product_policy" "institutions" {
  product_id          = azurerm_api_management_product.institutions.product_id
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  xml_content = file("${path.module}/policies/institutions/product_base_policy.xml")
}
