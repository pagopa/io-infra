module "apim_product_fims_admin" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

  product_id            = "fims-admin-api"
  api_management_name   = module.apim.name
  resource_group_name   = module.apim.resource_group_name
  display_name          = "FIMS ADMIN API"
  description           = "ADMIN API for FIMS openid provider."
  subscription_required = true
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/fims/_base_policy.xml")
}

module "api_fims_admin" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

  name                = "fims-admin-api"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  revision            = "1"
  display_name        = "FIMS ADMIN API"
  description         = "ADMIN API for FIMS."

  path        = ""
  protocols   = ["https"]
  product_ids = [module.apim_product_fims_admin.product_id]

  service_url = module.appservice_fims.domain

  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("./api/fims/admin/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("./api/fims/admin/policy.xml")
}
