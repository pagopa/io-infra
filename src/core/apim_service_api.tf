## Api Operator Search
module "apim_product_services_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.1.20"

  product_id   = "io-services-api"
  display_name = "IO SERVICES API"
  description  = "SERVICES API for IO platform."

  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/services_api/_base_policy.xml")
}

module "api_services_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.19"

  name                = "io-services-api"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  product_ids         = [module.apim_product_cgn_os.product_id]
  service_url         = local.apim_io_backend_api.service_url

  description           = "SERVICES API for IO platform."
  display_name          = "IO SERVICES API"
  path                  = "api/v1"
  protocols             = ["https"]
  revision              = "1"
  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("./api/services_api/v1/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("./api/services_api/v1/_base_policy.xml")
}
