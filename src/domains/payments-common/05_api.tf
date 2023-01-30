data "azurerm_api_management" "apim_api" {
  name                = local.apim_name
  resource_group_name = local.apim_resource_group_name
}

module "apim_product_payments" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.8"

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

module "apim_payments_updater_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.8"

  name                  = format("%s-payments-updater-api", local.product)
  api_management_name   = data.azurerm_api_management.apim_api.name
  resource_group_name   = data.azurerm_api_management.apim_api.resource_group_name
  product_ids           = [module.apim_product_payments.product_id]
  subscription_required = true
  service_url           = null

  description  = "IO Payments - Updater API"
  display_name = "IO Payments - Updater API"
  path         = "api/v1/payment"
  protocols    = ["https"]

  content_format = "openapi"

  content_value = file("./api/payments_updater/v1/_openapi.yaml")

  xml_content = file("./api/payments_updater/v1/_base_policy.xml")
}
