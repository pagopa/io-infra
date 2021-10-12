##############
## Products ##
##############

module "apim_io_backend_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "io-backend"
  display_name = "IO BACKEND"
  description  = "Product for IO backend"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/io_backend/_base_policy.xml")
}

/* module "apim_io_backend_api" {
  count  = var.io_backend_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-io-backend-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_io_backend_product[0].product_id]
  subscription_required = false

  description  = "mock ec api"
  display_name = "mock ec api"
  path         = "io-backend/api"
  protocols    = ["https"]

  service_url = format("https://%s/mockEcService", module.io_backend[0].default_site_hostname)

  content_value = templatefile("./api/mockec_api/v1/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/mockec_api/v1/_base_policy.xml")
} */
