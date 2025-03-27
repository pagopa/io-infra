module "apim_v2_product_cgn_support_func" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v7.64.0"

  product_id   = "cgnsupportfunc"
  display_name = "IO CGN API SUPPORT"
  description  = "Product for CGN Support Api"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("${path.module}/apis/cgn_support/_product_base_policy.xml")
}

data "http" "cgn_support_func_openapi" {
  url = "https://raw.githubusercontent.com/pagopa/io-cgn/refs/heads/main/apps/support-func/openapi/index.yaml"
}

module "api_v2_cgn_support_func" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v7.64.0"

  name = "io-cgn-support-api"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  product_ids = [module.apim_v2_product_cgn_support_func.product_id]
  service_url = null

  description           = "CGN SUPPORT API for IO platform."
  display_name          = "IO CGN SUPPORT API"
  path                  = "api/v1/cgn-support"
  protocols             = ["https"]
  revision              = "1"
  subscription_required = true

  content_format = "openapi"
  content_value  = data.http.cgn_support_func_openapi.body

  xml_content = file("${path.module}/apis/cgn_os/_base_policy.xml")
}
