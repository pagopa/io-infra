resource "azurerm_api_management_group" "cdc_read_group" {
  name                = "CdcReadGroup"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "CdcReadGroup"
  description         = "A group that enables PagoPa Operation to read CdC util informations about user"
}

module "apim_product_cdc_support_func" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v7.64.0"

  product_id   = "cdcsupportfunc"
  display_name = "IO CDC API SUPPORT"
  description  = "Product for CDC Support Api"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("${path.module}/apis/cdc_support/_product_base_policy.xml")
}

data "http" "cdc_support_func_openapi" {
  url = "https://raw.githubusercontent.com/pagopa/io-cdc/refs/tags/support-func%401.1.0/apps/support-func/api/internal.yaml"
}

module "api_cdc_support_func" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v7.64.0"

  name = "io-cdc-support-api"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  product_ids = [module.apim_product_cdc_support_func.product_id]
  service_url = null

  description           = "CDC SUPPORT API for IO platform."
  display_name          = "IO CDC SUPPORT API"
  path                  = "api/v1/cdc-support"
  protocols             = ["https"]
  revision              = "1"
  subscription_required = true

  content_format = "openapi"
  content_value  = data.http.cdc_support_func_openapi.body

  xml_content = file("${path.module}/apis/cdc_support/_base_policy.xml")
}
