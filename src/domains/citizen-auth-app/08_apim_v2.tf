data "azurerm_api_management" "apim_v2_api" {
  name                = "io-p-apim-v2-api"
  resource_group_name = "io-p-rg-internal"
}

## admin API
module "apim_product_fims_admin" {
  count  = var.fims_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

  product_id            = "fims-admin-api"
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name          = "FIMS ADMIN API"
  description           = "ADMIN API for FIMS openid provider."
  subscription_required = true
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/fims/_base_policy.xml")
}

module "api_fims_admin" {
  count  = var.fims_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

  name                = "fims-admin-api"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  revision            = "1"
  display_name        = "FIMS ADMIN API"
  description         = "ADMIN API for FIMS."

  path        = ""
  protocols   = ["https"]
  product_ids = [module.apim_product_fims_admin[0].product_id]

  service_url = format("https://%s", module.appservice_fims[0].default_site_hostname)

  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("./api/fims/admin/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("./api/fims/admin/policy.xml")
}

## public API
module "apim_product_fims_public" {
  count  = var.fims_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

  product_id            = "fims-public-api"
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name          = "FIMS PUBLIC API"
  description           = "PUBLIC API for FIMS openid provider."
  subscription_required = false
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/fims/_base_policy.xml")
}

module "api_fims_public" {
  count  = var.fims_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

  name                = "fims-public-api"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  revision            = "1"
  display_name        = "FIMS PUBLIC API"
  description         = "PUBLIC API for FIMS."

  path        = ""
  protocols   = ["https"]
  product_ids = [module.apim_product_fims_public[0].product_id]

  service_url = format("https://%s", module.appservice_fims[0].default_site_hostname)

  subscription_required = false

  content_format = "swagger-json"
  content_value = templatefile("./api/fims/public/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("./api/fims/public/policy.xml")
}
