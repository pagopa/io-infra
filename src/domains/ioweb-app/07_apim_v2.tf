module "apim_v2_bff_api" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v4.1.5"

  name                  = format("%s-ioweb-bff", local.product)
  api_management_name   = data.azurerm_api_management.apim_v2_api.name
  resource_group_name   = data.azurerm_api_management.apim_v2_api.resource_group_name
  product_ids           = ["io-web-api"]
  subscription_required = false

  service_url = format(local.bff_backend_url, data.azurerm_linux_function_app.function_web_profile.default_hostname)

  description  = "Bff API for IO Web platform"
  display_name = "IO Web - Bff"
  path         = local.bff_base_path
  protocols    = ["https"]

  content_format = "openapi-link"

  content_value = "https://raw.githubusercontent.com/pagopa/io-web-profile-backend/a2a6be1434e75089fb46e1aba50678cbbe32afd1/openapi/external.yaml"

  xml_content = file("./api/bff/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "unlock_user_session_policy" {
  api_name            = format("%s-ioweb-bff", local.product)
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  operation_id        = "unlockUserSession"

  xml_content = file("./api/bff/post_unlockusersession_policy/policy.xml")
}

resource "azurerm_api_management_named_value" "io_fn3_services_key_v2" {
  name                = "ioweb-profile-api-key"
  api_management_name = data.azurerm_api_management.apim_v2_api.name
  resource_group_name = data.azurerm_api_management.apim_v2_api.resource_group_name
  display_name        = "ioweb-profile-api-key"
  value               = data.azurerm_key_vault_secret.io_fn3_services_key_secret.value
  secret              = "true"
}
