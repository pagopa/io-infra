module "apim_product_fims_public" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

  product_id            = "fims-public-api"
  api_management_name   = module.apim.name
  resource_group_name   = module.apim.resource_group_name
  display_name          = "FIMS PUBLIC API"
  description           = "PUBLIC API for FIMS openid provider."
  subscription_required = false
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/fims/_base_policy.xml")
}
module "api_fims_public" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

  name                = "fims-public-api"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  revision            = "1"
  display_name        = "FIMS PUBLIC API"
  description         = "PUBLIC API for FIMS."

  path        = ""
  protocols   = ["https"]
  product_ids = [module.apim_product_fims_public.product_id]

  service_url = module.appservice_fims.domain

  subscription_required = false

  content_format = "swagger-json"
  content_value = templatefile("./api/fims/public/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("./api/fims/public/policy.xml")
}
