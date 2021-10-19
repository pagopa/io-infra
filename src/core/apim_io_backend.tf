##############
## Products ##
##############

module "apim_io_backend_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "io-backend"
  display_name = "IO BACKEND"
  description  = "Product for IO backend"

  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/io_backend/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "io_backend_api" {
  name                = format("%s-io-backend-api", var.env_short)
  resource_group_name = module.apim.resource_group_name
  api_management_name = module.apim.name
  display_name        = "IO BACKEND API"
  versioning_scheme   = "Segment"
}

module "apim_io_backend_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-io-backend-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = module.apim.resource_group_name
  product_ids           = [module.apim_io_backend_product[0].product_id]
  subscription_required = false
  version_set_id        = azurerm_api_management_api_version_set.io_backend_api.id
  api_version           = "v1"
  service_url           = null

  description  = "BACKEND API for IO app"
  display_name = "IO BACKEND API"
  path         = "api/v1"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/io_backend/v1/_openapi.yaml.tpl", {
    host = local.apim_hostname_api_app_internal
  })

  xml_content = file("./api/io_backend/v1/_base_policy.xml")
}
