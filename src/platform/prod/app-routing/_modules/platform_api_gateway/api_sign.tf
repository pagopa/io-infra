resource "azurerm_api_management_product" "sign" {
  product_id   = "io-sign"
  display_name = "IO Sign"
  description  = "Product for IO Sign APIs"

  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false
}

resource "azurerm_api_management_product_policy" "sign" {
  product_id          = azurerm_api_management_product.sign.product_id
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  xml_content = file("${path.module}/policies/sign/product_base_policy.xml")
}
