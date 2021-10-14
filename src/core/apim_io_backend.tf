##############
## Products ##
##############

module "apim_io_backend_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "io-backend"
  display_name = "IO BACKEND"
  description  = "Product for IO backend"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/io_backend/_base_policy.xml")
}

module "apim_io_backend_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-io-backend-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name
  product_ids           = [module.apim_io_backend_product[0].product_id]
  subscription_required = false

  description  = "BACKEND API for IO app"
  display_name = "IO BACKEND API"
  path         = "app"
  protocols    = ["https"]

  service_url = format("https://%s/mockEcService", module.io_backend[0].default_site_hostname)

  content_format = "openapi-link"
  content_value = "https://github.com/pagopa/io-backend/blob/v7.23.0-RELEASE/api_backend.yaml"

  xml_content = file("./api/mockec_api/v1/_base_policy.xml")
}
