data "azurerm_api_management" "apim_api" {
  name                = local.apim_name
  resource_group_name = local.apim_resource_group_name
}

module "apim_product_payments" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "io-payments-api"
  display_name = "IO PAYMENTS API"
  description  = "Product for IO payments"

  api_management_name = data.azurerm_api_management.apim_api.name
  resource_group_name = data.azurerm_api_management.apim_api.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/payments/_base_policy.xml")
}
