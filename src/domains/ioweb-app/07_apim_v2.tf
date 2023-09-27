data "azurerm_api_management" "apim_v2_api" {
  name                = local.apim_v2_name
  resource_group_name = local.apim_resource_group_name
}

module "apim_v2_bff_api" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v4.1.5"

  name                  = format("%s-ioweb-bff", local.product)
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_ids           = ["io-web-api"]
  subscription_required = false

  service_url = format("https://%s", module.function_ioweb_profile.default_hostname)

  description  = "Bff API for IO Web platform"
  display_name = "IO Web - Bff"
  path         = local.bff_base_path
  protocols    = ["https"]

  content_format = "openapi-link"

  content_value = "https://raw.githubusercontent.com/pagopa/io-web-profile/master/openApi/openapi.yaml"

  xml_content = file("./api/bff/_base_policy.xml")
}
