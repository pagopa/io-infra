data "azurerm_api_management" "apim_api" {
  name                = "io-p-apim-api"
  resource_group_name = "io-p-rg-internal"
}

module "apim_io_sign_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "io-sign-api"
  display_name = "IO SIGN API"
  description  = "Product for IO sign"

  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./io_sign_policy.xml")
}

module "apim_io_sign_issuer_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-io-sign-issuer-api", var.env_short)
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  product_ids           = [module.apim_io_sign_product.product_id]
  subscription_required = false
  api_version           = "v1"
  service_url           = null

  description  = "IO Sign - Issuer API"
  display_name = "IO Sign - Issuer API"
  path         = "sign"
  protocols    = ["https"]

  content_format = "swagger-json"

  content_value = templatefile("./api/issuer/swagger.json.tpl", {
    host = "the-host-here"
  })

  xml_content = file("./api/issuer/policy.xml")
}

