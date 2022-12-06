## Api Operator Search
module "apim_product_cgn_os" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.1.20"

  product_id   = "cgnoperatorsearch"
  display_name = "IO CGN API OPERATOR SEARCH"
  description  = "Product for CGN Operator Search Api"

  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/cgn_os/_base_policy.xml")
}

module "api_cgn_os" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.19"

  name                = "io-cgn-os-api"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  product_ids         = [module.apim_product_cgn_os.product_id]
  service_url         = local.apim_io_backend_api.service_url

  description           = "CGN OPERATOR SEARCH API for IO platform."
  display_name          = "IO CGN OPERATOR SEARCH API"
  path                  = "api/v1/operator-search/cgn"
  protocols             = ["https"]
  revision              = "1"
  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("./api/cgn_os/v1/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("./api/cgn_os/v1/_base_policy.xml")
}
