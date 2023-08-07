## Api merchant
module "apim_v2_product_merchant" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

  product_id   = "cgnmerchant"
  display_name = "IO CGN API MERCHANT"
  description  = "Product for CGN Merchant Api"

  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/cgn/_base_policy.xml")
}

module "api_v2_cgn_merchant" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

  name                = "io-cgn-merchant-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  product_ids         = [module.apim_v2_product_merchant.product_id]
  service_url         = local.apim_v2_io_backend_api.service_url

  description           = "CGN MERCHANT API for IO platform."
  display_name          = "IO CGN MERCHANT API"
  path                  = "api/v1/merchant/cgn"
  protocols             = ["https"]
  revision              = "1"
  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("./api/cgn/v1/_swagger.json.tpl",
    {
      host = "api.io.italia.it"
    }
  )

  xml_content = file("./api/cgn/v1/_base_policy.xml")
}

# Named Values function-cgn-merchant
resource "azurerm_api_management_named_value" "io_fn_cgnmerchant_url_v2" {
  name                = "io-fn-cgnmerchant-url"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  display_name        = "io-fn-cgnmerchant-url"
  value               = "https://${module.function_cgn_merchant.default_hostname}"
}

data "azurerm_key_vault_secret" "io_fn_cgnmerchant_key_secret_v2" {
  name         = "io-fn-cgnmerchant-KEY-APIM"
  key_vault_id = module.key_vault_common.id
}

resource "azurerm_api_management_named_value" "io_fn_cgnmerchant_key_v2" {
  name                = "io-fn-cgnmerchant-key"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  display_name        = "io-fn-cgnmerchant-key"
  value               = data.azurerm_key_vault_secret.io_fn_cgnmerchant_key_secret_v2.value
  secret              = "true"
}

## App registration for cgn backend portal ##

### cgnonboardingportal user identity
data "azurerm_key_vault_secret" "cgn_onboarding_backend_identity_v2" {
  name         = "cgn-onboarding-backend-PRINCIPALID"
  key_vault_id = module.key_vault_common.id
}

resource "azurerm_role_assignment" "service_contributor_v2" {
  count                = var.env_short == "p" ? 1 : 0
  scope                = module.apim_v2.id
  role_definition_name = "API Management Service Contributor"
  principal_id         = data.azurerm_key_vault_secret.cgn_onboarding_backend_identity_v2.value
}
