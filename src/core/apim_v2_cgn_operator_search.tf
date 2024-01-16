## Api Operator Search
module "apim_v2_product_cgn_os" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.28.0"

  product_id   = "cgnoperatorsearch"
  display_name = "IO CGN API OPERATOR SEARCH"
  description  = "Product for CGN Operator Search Api"

  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/cgn_os/_base_policy.xml")
}

module "api_v2_cgn_os" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.28.0"

  name                = "io-cgn-os-api"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  product_ids         = [module.apim_v2_product_cgn_os.product_id]
  service_url         = local.apim_v2_io_backend_api.service_url

  description           = "CGN OPERATOR SEARCH API for IO platform."
  display_name          = "IO CGN OPERATOR SEARCH API"
  path                  = "api/v1/operator-search/cgn"
  protocols             = ["https"]
  revision              = "1"
  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("./api/cgn_os/v1/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("./api/cgn_os/v1/_base_policy.xml")
}

resource "azurerm_api_management_named_value" "cgnonboardingportal_os_url_value_v2" {
  name                = "cgnonboardingportal-os-url"
  api_management_name = module.apim_v2.name
  resource_group_name = azurerm_resource_group.rg_internal.name
  display_name        = "cgnonboardingportal-os-url"
  value               = format("https://cgnonboardingportal-%s-op.azurewebsites.net", var.env_short)
}

resource "azurerm_api_management_named_value" "cgnonboardingportal_os_key_v2" {
  name                = "cgnonboardingportal-os-key"
  api_management_name = module.apim_v2.name
  resource_group_name = azurerm_resource_group.rg_internal.name
  display_name        = "cgnonboardingportal-os-key"
  value               = data.azurerm_key_vault_secret.cgnonboardingportal_os_key.value
  secret              = true
}

resource "azurerm_api_management_named_value" "cgnonboardingportal_os_header_name_v2" {
  name                = "cgnonboardingportal-os-header-name"
  api_management_name = module.apim_v2.name
  resource_group_name = azurerm_resource_group.rg_internal.name
  display_name        = "cgnonboardingportal-os-header-name"
  value               = data.azurerm_key_vault_secret.cgnonboardingportal_os_header_name.value
  secret              = true
}
