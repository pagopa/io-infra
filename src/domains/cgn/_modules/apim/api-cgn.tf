module "apim_v2_product_merchant" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v7.64.0"

  product_id   = "cgnmerchant"
  display_name = "IO CGN API MERCHANT"
  description  = "Product for CGN Merchant Api"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("${path.module}/apis/cgn/_product_base_policy.xml")
}

module "api_v2_cgn_merchant" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v7.64.0"

  name = "io-cgn-merchant-api"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  product_ids = [] # [module.apim_v2_product_merchant.product_id]
  service_url = null

  description           = "CGN MERCHANT API for IO platform."
  display_name          = "IO CGN MERCHANT API"
  path                  = "api/v1/merchant/cgn"
  protocols             = ["https"]
  revision              = "1"
  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("${path.module}/apis/cgn/_swagger.json.tpl",
    {
      host = "api.io.italia.it"
    }
  )

  xml_content = file("${path.module}/apis/cgn/_base_policy.xml")
}
