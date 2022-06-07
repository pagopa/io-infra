data "azurerm_api_management" "apim_api" {
  name                = "io-p-apim-api"
  resource_group_name = "io-p-rg-internal"
}

resource "azurerm_api_management_named_value" "io_fn_sign_url" {
  name                = "io-fn-sign-url"
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  display_name        = "io-fn-sign-url"
  value               = format("https://%s-sign-func.azurewebsites.net", local.product)
}

data "azurerm_key_vault_secret" "io_fn_sign_key" {
  name         = "io-fn-sign-key"
  key_vault_id = module.key_vault.id
}

resource "azurerm_api_management_named_value" "io_fn_sign_key" {
  name                = "io-fn-sign-key"
  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  display_name        = "io-fn-sign-key"
  value               = data.azurerm_key_vault_secret.io_fn_sign_key.value
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

resource "azurerm_api_management_api_version_set" "io_sign_issuer_api" {
  name                = format("%s-sign-issuer-api", local.product)
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name
  api_management_name = data.azurerm_api_management.apim_api.name
  display_name        = "IO Sign - Issuer API"
  versioning_scheme   = "Segment"
}

module "apim_io_sign_issuer_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-sign-issuer-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_api.name
  resource_group_name   = data.azurerm_api_management.apim_api.resource_group_name
  product_ids           = [module.apim_io_sign_product.product_id]
  version_set_id        = azurerm_api_management_api_version_set.io_sign_issuer_api.id
  subscription_required = false
  api_version           = "v1"
  service_url           = null

  description  = "IO Sign - Issuer API"
  display_name = "IO Sign - Issuer API"
  path         = "api/sign"
  protocols    = ["https"]

  content_format = "swagger-json"

  content_value = templatefile("./api/issuer/v1/_swagger.json.tpl", {
    host = "api.io.pagopa.it"
  })

  xml_content = file("./api/issuer/v1/_base_policy.xml")
}
