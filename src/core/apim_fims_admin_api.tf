module "apim_product_admin" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

  product_id            = "fims-admin-api"
  api_management_name   = module.apim.name
  resource_group_name   = module.apim.resource_group_name
  display_name          = "FIMS ADMIN API"
  description           = "ADMIN API for FIMS openid provider."
  subscription_required = true
  approval_required     = false
  published             = true

  policy_xml = file("./api_product/fims/_base_policy.xml")
}

# Named Value fn3-admin
resource "azurerm_api_management_named_value" "fims_admin_url" {
  name                = "fims-admin-url"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "fims-admin-url"
  value               = "https://io-p-citizen-auth-weu-prod01-app-fims.azurewebsites.net"
}

data "azurerm_key_vault_secret" "fims_admin_key_secret" {
  name         = "fimsadmin-KEY-APIM"
  key_vault_id = module.key_vault_common.id
}

resource "azurerm_api_management_named_value" "fims_admin_key" {
  name                = "fims-admin-key"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "fims-admin-key"
  value               = data.azurerm_key_vault_secret.fims_admin_key_secret.value
  secret              = "true"
}

module "api_admin" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

  name                = "fims-admin-api"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  revision            = "1"
  display_name        = "FIMS ADMIN API"
  description         = "ADMIN API for FIMS."

  path        = ""
  protocols   = ["https"]
  product_ids = [module.apim_product_admin.product_id]

  service_url = null

  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("./api/fims/admin/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("./api/fims/admin/policy.xml")
}
