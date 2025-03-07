module "apim_itn_product_services" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v8.27.0"

  product_id            = "io-services-api"
  api_management_name   = data.azurerm_api_management.apim_itn.name
  resource_group_name   = data.azurerm_api_management.apim_itn.resource_group_name
  display_name          = "IO SERVICES API"
  description           = "SERVICES API for IO platform."
  subscription_required = true
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/io_services/_base_policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "submit_message_for_user_policy_itn" {
  api_name            = "io-services-api"
  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  operation_id        = "submitMessageforUser"

  xml_content = file("./api/io_services/v1/post_submitmessageforuser_policy/policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "submit_message_for_user_with_fiscalcode_in_body_policy_itn" {
  api_name            = "io-services-api"
  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  operation_id        = "submitMessageforUserWithFiscalCodeInBody"

  xml_content = file("./api/io_services/v1/post_submitmessageforuserwithfiscalcodeinbody_policy/policy.xml")
}

# Named Value fn3-services
resource "azurerm_api_management_named_value" "io_fn3_services_url_itn" {
  name                = "io-fn3-services-url"
  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  display_name        = "io-fn3-services-url"
  value               = "https://io-p-fn3-services.azurewebsites.net"
}

data "azurerm_key_vault_secret" "io_fn3_services_key_secret_itn" {
  name         = "fn3services-KEY-APIM"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

resource "azurerm_api_management_named_value" "io_fn3_services_key_itn" {
  name                = "io-fn3-services-key"
  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  display_name        = "io-fn3-services-key"
  value               = data.azurerm_key_vault_secret.io_fn3_services_key_secret_itn.value
  secret              = "true"
}

# Named value fn3-eucovidcert

data "azurerm_key_vault_secret" "io_fn3_eucovidcert_key_secret_itn" {
  name         = "io-fn3-eucovidcert-KEY-APIM"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

resource "azurerm_api_management_named_value" "io_fn3_eucovidcert_key_itn" {
  name                = "io-fn3-eucovidcert-key"
  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  display_name        = "io-fn3-eucovidcert-key"
  value               = data.azurerm_key_vault_secret.io_fn3_eucovidcert_key_secret_itn.value
  secret              = "true"
}

# alternative url, for differential routing (example: progressive rollout)
resource "azurerm_api_management_named_value" "io_fn3_eucovidcert_url_alt_itn" {
  name                = "io-fn3-eucovidcert-url-alt"
  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  display_name        = "io-fn3-eucovidcert-url-alt"
  value               = "https://io-p-eucovidcert-fn.azurewebsites.net"
}

# Named Value api gad certificate header
data "azurerm_key_vault_secret" "api_gad_client_certificate_verified_header_secret_itn" {
  name         = "apigad-GAD-CLIENT-CERTIFICATE-VERIFIED-HEADER"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

resource "azurerm_api_management_named_value" "api_gad_client_certificate_verified_header_itn" {
  name                = "apigad-gad-client-certificate-verified-header"
  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  display_name        = "apigad-gad-client-certificate-verified-header"
  value               = data.azurerm_key_vault_secret.api_gad_client_certificate_verified_header_secret_itn.value
  secret              = "true"
}

module "api_itn_services" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.27.0"

  name                = "io-services-api"
  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name
  revision            = "1"
  display_name        = "IO SERVICES API"
  description         = "SERVICES API for IO platform."

  path        = "api/v1"
  protocols   = ["http", "https"]
  product_ids = [module.apim_itn_product_services.product_id]

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
