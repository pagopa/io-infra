data "azurerm_api_management" "apim_api" {
  name                = "io-p-apim-api"
  resource_group_name = "io-p-rg-internal"
}

resource "azurerm_api_management_named_value" "io_fn_sign_issuer_url" {
  name                = "io-fn-sign-issuer-url"
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  display_name        = "io-fn-sign-issuer-url"
  value               = format("https://%s-sign-issuer-func.azurewebsites.net", local.product)
}

resource "azurerm_api_management_named_value" "io_fn_sign_issuer_key" {
  name                = "io-fn-sign-issuer-key"
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  display_name        = "io-fn-sign-issuer-key"
  value               = module.key_vault_secrets.values["io-fn-sign-issuer-key"].value
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

  policy_xml = file("./api_product/sign/_base_policy.xml")
}

module "apim_io_sign_issuer_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-sign-issuer-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_api.name
  resource_group_name   = data.azurerm_api_management.apim_api.resource_group_name
  product_ids           = [module.apim_io_sign_product.product_id]
  subscription_required = false
  service_url           = null

  description  = "IO Sign - Issuer API"
  display_name = "IO Sign - Issuer API"
  path         = "api/v1/sign"
  protocols    = ["https"]

  content_format = "openapi"

  content_value = file("./api/issuer/v1/_openapi.yaml")

  xml_content = file("./api/issuer/v1/_base_policy.xml")
}
