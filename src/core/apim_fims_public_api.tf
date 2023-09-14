module "apim_product_public" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

  product_id            = "fims-public-api"
  api_management_name   = module.apim.name
  resource_group_name   = module.apim.resource_group_name
  display_name          = "FIMS PUBLIC API"
  description           = "PUBLIC API for FIMS openid provider."
  subscription_required = false
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/fims/_base_policy.xml")
}

# Named Value io_fn3_public_url
resource "azurerm_api_management_named_value" "fims_public_url" {
  name                = "fims-public-url"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "fims-public-url"
  value               = "https://io-p-citizen-auth-weu-prod01-app-fims.azurewebsites.net"
}

data "azurerm_key_vault_secret" "fims_public_key_secret" {
  name         = "fimspublic-KEY-APIM"
  key_vault_id = module.key_vault_common.id
}

resource "azurerm_api_management_named_value" "fims_public_key" {
  name                = "fims-public-key"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "fims-public-key"
  value               = data.azurerm_key_vault_secret.fims_public_key_secret.value
  secret              = "true"
}

module "api_public" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

  name                = "fims-public-api"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  revision            = "1"
  display_name        = "FIMS PUBLIC API"
  description         = "PUBLIC API for FIMS."

  path        = ""
  protocols   = ["https"]
  product_ids = [module.apim_product_public.product_id]

  service_url = null

  subscription_required = false

  content_format = "swagger-json"
  content_value = templatefile("./api/fims/public/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("./api/fims/public/policy.xml")
}
