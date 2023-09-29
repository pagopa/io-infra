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

  service_url = format("https://%s/api/v1", module.function_ioweb_profile.default_hostname)

  description  = "Bff API for IO Web platform"
  display_name = "IO Web - Bff"
  path         = local.bff_base_path
  protocols    = ["https"]

  content_format = "openapi-link"

  content_value = "https://raw.githubusercontent.com/pagopa/io-web-profile-backend/a2a6be1434e75089fb46e1aba50678cbbe32afd1/openapi/external.yaml"

  xml_content = file("./api/bff/policy.xml")
}

data "azurerm_key_vault" "key_vault_common" {
  name                = format("%s-ioweb-kv", local.product)
  resource_group_name = format("%s-ioweb-sec-rg", local.product)
}

data "azurerm_key_vault_secret" "io_fn3_services_key_secret" {
  name         = "ioweb-profile-api-key-apim"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

resource "azurerm_api_management_named_value" "io_fn3_services_key_v2" {
  name                = "ioweb-profile-api-key"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "ioweb-profile-api-key"
  value               = data.azurerm_key_vault_secret.io_fn3_services_key_secret.value
  secret              = "true"
}
