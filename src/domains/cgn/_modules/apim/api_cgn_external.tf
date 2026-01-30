resource "azurerm_api_management_group" "cgn_external_activation_group" {
  name                = "CgnExternalActivationGroup"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "CgnExternalActivationGroup"
  description         = "A group that enables a subscription to activate a Cgn"
}

module "apim_v2_product_cgn_external" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v7.64.0"

  product_id   = "cgnexternalapi"
  display_name = "IO CGN API EXTERNAL"
  description  = "Product for CGN External Api"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("${path.module}/apis/cgn_external/_product_base_policy.xml")
}

data "http" "cgn_external_openapi" {
  url = "https://raw.githubusercontent.com/pagopa/io-cgn/refs/tags/card-func@4.1.0/apps/card-func/openapi/external-activation/internal.yaml"
}

module "api_v1_cgn_external" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v7.64.0"

  name = "io-cgn-external-api"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  product_ids = [module.apim_v2_product_cgn_external.product_id]
  service_url = null

  description           = "CGN EXTERNAL API for operators."
  display_name          = "IO CGN EXTERNAL API"
  path                  = "api/cgn-external/v1"
  protocols             = ["https"]
  revision              = "1"
  subscription_required = true

  content_format = "openapi"
  content_value  = data.http.cgn_external_openapi.body

  xml_content = file("${path.module}/apis/cgn_external/_base_policy.xml")
}
