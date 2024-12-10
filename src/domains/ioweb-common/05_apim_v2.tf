# API Product

module "apim_v2_product_ioweb" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v8.56.0"

  product_id   = "io-web-api"
  display_name = "IO WEB API"
  description  = "Product for IO WEB Api & Authentication"

  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/ioweb/_base_policy.xml")
}

module "apim_v2_spid_login_api" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.56.0"

  name                  = format("%s-ioweb-auth", local.product)
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_ids           = [module.apim_v2_product_ioweb.product_id]
  subscription_required = false

  service_url = format("https://%s", module.spid_login.default_site_hostname)

  description  = "Login SPID Service Provider"
  display_name = "IO Web - Authentication"
  path         = local.spid_login_base_path
  protocols    = ["https"]

  content_format = "openapi"

  # NOTE: This openapi does not contains `upgradeToken` endpoint, since it's not necessary
  content_value = file("./api/ioweb/spid-login/_swagger.json")

  xml_content = file("./api/ioweb/spid-login/_base_policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "spid_acs" {
  api_name            = format("%s-ioweb-auth", local.product)
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  operation_id        = "postACS"

  xml_content = file("./api/ioweb/spid-login/_postacs_policy.xml")
}
