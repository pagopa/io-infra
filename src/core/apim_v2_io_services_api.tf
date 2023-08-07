module "apim_v2_product_services" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

  product_id            = "io-services-api"
  api_management_name   = module.apim_v2.name
  resource_group_name   = module.apim_v2.resource_group_name
  display_name          = "IO SERVICES API"
  description           = "SERVICES API for IO platform."
  subscription_required = true
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/io_services/_base_policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "submit_message_for_user_policy_v2" {
  api_name            = "io-services-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  operation_id        = "submitMessageforUser"

  xml_content = file("./api/io_services/v1/post_submitmessageforuser_policy/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "submit_message_for_user_with_fiscalcode_in_body_policy_v2" {
  api_name            = "io-services-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  operation_id        = "submitMessageforUserWithFiscalCodeInBody"

  xml_content = file("./api/io_services/v1/post_submitmessageforuserwithfiscalcodeinbody_policy/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "create_service_policy_v2" {
  api_name            = "io-services-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  operation_id        = "createService"

  xml_content = file("./api/io_services/v1/post_createservice_policy/policy.xml")
}

# Temporary policy resource for the time needed to upgrade apim to v2
resource "azurerm_api_management_api_operation_policy" "regenerate_service_key_policy_v2" {
  api_name            = "io-services-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  operation_id        = "regenerateServiceKey"

  xml_content = file("./api/io_services/v1/temp_mock_response_500_policy/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "update_service_policy_v2" {
  api_name            = "io-services-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  operation_id        = "updateService"

  xml_content = file("./api/io_services/v1/temp_mock_response_500_policy/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "upload_organization_logo_policy_v2" {
  api_name            = "io-services-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  operation_id        = "uploadOrganizationLogo"

  xml_content = file("./api/io_services/v1/temp_mock_response_500_policy/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "upload_service_logo_policy_v2" {
  api_name            = "io-services-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  operation_id        = "uploadServiceLogo"

  xml_content = file("./api/io_services/v1/temp_mock_response_500_policy/policy.xml")
}

# Named Value fn3-services
resource "azurerm_api_management_named_value" "io_fn3_services_url_v2" {
  name                = "io-fn3-services-url"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  display_name        = "io-fn3-services-url"
  value               = "https://io-p-fn3-services.azurewebsites.net"
}

data "azurerm_key_vault_secret" "io_fn3_services_key_secret_v2" {
  name         = "fn3services-KEY-APIM"
  key_vault_id = module.key_vault_common.id
}

resource "azurerm_api_management_named_value" "io_fn3_services_key_v2" {
  name                = "io-fn3-services-key"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  display_name        = "io-fn3-services-key"
  value               = data.azurerm_key_vault_secret.io_fn3_services_key_secret_v2.value
  secret              = "true"
}

# Named value fn3-eucovidcert

data "azurerm_key_vault_secret" "io_fn3_eucovidcert_key_secret_v2" {
  name         = "io-fn3-eucovidcert-KEY-APIM"
  key_vault_id = module.key_vault_common.id
}

resource "azurerm_api_management_named_value" "io_fn3_eucovidcert_key_v2" {
  name                = "io-fn3-eucovidcert-key"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  display_name        = "io-fn3-eucovidcert-key"
  value               = data.azurerm_key_vault_secret.io_fn3_eucovidcert_key_secret_v2.value
  secret              = "true"
}

# alternative url, for differential routing (example: progressive rollout)
resource "azurerm_api_management_named_value" "io_fn3_eucovidcert_url_alt_v2" {
  name                = "io-fn3-eucovidcert-url-alt"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  display_name        = "io-fn3-eucovidcert-url-alt"
  value               = "https://io-p-eucovidcert-fn.azurewebsites.net"
}

# Named Value api gad certificate header
data "azurerm_key_vault_secret" "api_gad_client_certificate_verified_header_secret_v2" {
  name         = "apigad-GAD-CLIENT-CERTIFICATE-VERIFIED-HEADER"
  key_vault_id = module.key_vault_common.id
}

resource "azurerm_api_management_named_value" "api_gad_client_certificate_verified_header_v2" {
  name                = "apigad-gad-client-certificate-verified-header"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  display_name        = "apigad-gad-client-certificate-verified-header"
  value               = data.azurerm_key_vault_secret.api_gad_client_certificate_verified_header_secret_v2.value
  secret              = "true"
}

module "api_v2_services" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

  name                = "io-services-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  revision            = "1"
  display_name        = "IO SERVICES API"
  description         = "SERVICES API for IO platform."

  path        = "api/v1"
  protocols   = ["http", "https"]
  product_ids = [module.apim_v2_product_services.product_id]

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
