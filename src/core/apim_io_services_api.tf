## Api Operator Search
module "apim_product_services" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.1.20"

  product_id            = "io-services-api"
  api_management_name   = module.apim.name
  resource_group_name   = module.apim.resource_group_name
  display_name          = "IO SERVICES API"
  description           = "SERVICES API for IO platform."
  subscription_required = true
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/io_services/_base_policy.xml")
}

# TODO plugin crash
# resource "azurerm_api_management_api_operation" "submit_message_for_user" {
#   operation_id        = "submitMessageforUser"
#   api_name            = "io-services-api"
#   api_management_name = module.apim.name
#   resource_group_name = module.apim.resource_group_name
#   display_name        = "Submit a Message passing the user fiscal_code as path parameter"
#   method              = "POST"
#   url_template        = "/messages/{fiscal_code}"
# }

resource "azurerm_api_management_api_operation_policy" "submit_message_for_user_policy" {
  api_name            = "io-services-api" # azurerm_api_management_api_operation.submit_message_for_user.api_name
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  operation_id        = "submitMessageforUser" # azurerm_api_management_api_operation.submit_message_for_user.operation_id

  xml_content = file("./api/io_services/v1/post_submitmessageforuser_policy/policy.xml")
}

# TODO plugin crash
# resource "azurerm_api_management_api_operation" "submit_message_for_user_with_fiscalcode_in_body" {
#   operation_id        = "submitMessageforUserWithFiscalCodeInBody"
#   api_name            = "io-services-api"
#   api_management_name = module.apim.name
#   resource_group_name = module.apim.resource_group_name
#   display_name        = "Submit a Message passing the user fiscal_code in the request body"
#   method              = "POST"
#   url_template        = "/messages"
# }

resource "azurerm_api_management_api_operation_policy" "submit_message_for_user_with_fiscalcode_in_body_policy" {
  api_name            = "io-services-api" # azurerm_api_management_api_operation.submit_message_for_user_with_fiscalcode_in_body.api_name
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  operation_id        = "submitMessageforUserWithFiscalCodeInBody" # azurerm_api_management_api_operation.submit_message_for_user_with_fiscalcode_in_body.operation_id

  xml_content = file("./api/io_services/v1/post_submitmessageforuserwithfiscalcodeinbody_policy/policy.xml")
}

# Named Value fn3-services
resource "azurerm_api_management_named_value" "io_fn3_services_url" {
  name                = "io-fn3-services-url"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "io-fn3-services-url"
  value               = "https://io-p-fn3-services.azurewebsites.net"
}

data "azurerm_key_vault_secret" "io_fn3_services_key_secret" {
  name         = "fn3services-KEY-APIM"
  key_vault_id = data.azurerm_key_vault.common.id
}

resource "azurerm_api_management_named_value" "io_fn3_services_key" {
  name                = "io-fn3-services-key"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "io-fn3-services-key"
  value               = data.azurerm_key_vault_secret.io_fn3_services_key_secret.value
  secret              = "true"
}

# Named value fn3-eucovidcert
resource "azurerm_api_management_named_value" "io_fn3_eucovidcert_url" {
  name                = "io-fn3-eucovidcert-url"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "io-fn3-eucovidcert-url"
  value               = "https://io-p-fn3-eucovidcert.azurewebsites.net"
}

data "azurerm_key_vault_secret" "io_fn3_eucovidcert_key_secret" {
  name         = "io-fn3-eucovidcert-KEY-APIM"
  key_vault_id = data.azurerm_key_vault.common.id
}

resource "azurerm_api_management_named_value" "io_fn3_eucovidcert_key" {
  name                = "io-fn3-eucovidcert-key"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "io-fn3-eucovidcert-key"
  value               = data.azurerm_key_vault_secret.io_fn3_eucovidcert_key_secret.value
  secret              = "true"
}

# Named Value api gad certificate header
data "azurerm_key_vault_secret" "api_gad_client_certificate_verified_header_secret" {
  name         = "apigad-GAD-CLIENT-CERTIFICATE-VERIFIED-HEADER"
  key_vault_id = data.azurerm_key_vault.common.id
}

resource "azurerm_api_management_named_value" "api_gad_client_certificate_verified_header" {
  name                = "apigad-gad-client-certificate-verified-header"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "apigad-gad-client-certificate-verified-header"
  value               = data.azurerm_key_vault_secret.api_gad_client_certificate_verified_header_secret.value
  secret              = "true"
}

module "api_services" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.19"

  name                = "io-services-api"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  revision            = "1"
  display_name        = "IO SERVICES API"
  description         = "SERVICES API for IO platform."

  path        = "api/v1"
  protocols   = ["http", "https"]
  product_ids = [module.apim_product_services.product_id]

  service_url = null

  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("./api/io_services/v1/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("./api/io_services/v1/policy.xml")
}
