#######
# CGN #
#######

module "apim_itn_product_merchant" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v7.64.0"

  product_id   = "cgnmerchant"
  display_name = "IO CGN API MERCHANT"
  description  = "Product for CGN Merchant Api"

  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("${path.module}/apis/cgn/_product_base_policy.xml")
}

module "api_itn_cgn_merchant" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v7.64.0"

  name = "io-cgn-merchant-api"

  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name

  product_ids = [module.apim_itn_product_merchant.product_id]
  service_url = null

  description           = "CGN MERCHANT API for IO platform."
  display_name          = "IO CGN MERCHANT API"
  path                  = "api/v1/merchant/cgn"
  protocols             = ["https"]
  revision              = "1"
  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("${path.module}/apis/cgn/_swagger.json.tpl",
    {
      host = "api.io.italia.it"
    }
  )

  xml_content = file("${path.module}/apis/cgn/_base_policy.xml")
}


##########
# CGN OS #
##########

module "apim_itn_product_cgn_os" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v7.64.0"

  product_id   = "cgnoperatorsearch"
  display_name = "IO CGN API OPERATOR SEARCH"
  description  = "Product for CGN Operator Search Api"

  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("${path.module}/apis/cgn_os/_product_base_policy.xml")
}

module "api_itn_cgn_os" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v7.64.0"

  name = "io-cgn-os-api"

  api_management_name = data.azurerm_api_management.apim_itn.name
  resource_group_name = data.azurerm_api_management.apim_itn.resource_group_name

  product_ids = [module.apim_itn_product_cgn_os.product_id]
  service_url = null

  description           = "CGN OPERATOR SEARCH API for IO platform."
  display_name          = "IO CGN OPERATOR SEARCH API"
  path                  = "api/v1/operator-search/cgn"
  protocols             = ["https"]
  revision              = "1"
  subscription_required = true

  content_format = "swagger-json"
  content_value = templatefile("${path.module}/apis/cgn_os/_swagger.json.tpl",
    {
      host = "api.io.pagopa.it"
    }
  )

  xml_content = file("${path.module}/apis/cgn_os/_base_policy.xml")
}
