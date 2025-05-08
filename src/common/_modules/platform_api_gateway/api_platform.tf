module "api_gateway_io_platform_product" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v8.92.2"

  product_id   = "io-platform"
  display_name = "IO PLATFORM"
  description  = "Product for IO Plaftorm APIs"

  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./apis/base_policy.xml")
}

data "http" "platform_io_backend_openapi" {
  # TODO: update this URL with master branch when the new openapi spec will be released
  url = "https://raw.githubusercontent.com/pagopa/io-backend/refs/heads/refactor-openapi-specs/openapi/generated/api_platform.yaml"
}

module "api_gateway_io_platform_api" {
  source = "github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v8.92.2"

  name                  = format("%s-p-app-backend-platform-api", var.prefix)
  api_management_name = module.platform_api_gateway.name
  resource_group_name = module.platform_api_gateway.resource_group_name
  product_ids           = [module.api_gateway_io_platform_product.product_id]
  subscription_required = false
  api_version           = "v1"
  service_url           = null

  description  = "IO Platform app-backend API"
  display_name = "app-backend"
  path         = "/"
  protocols    = ["https"]

  content_format = "openapi"
  content_value  = data.http.platform_io_backend_openapi.body

  xml_content = file("./apis/platform/_base_policy.xml")

  api_operation_policies = [
    {
      operation_id = "getServicesStatus"
      xml_content  = file("./apis/platform/v1/get_services_status_policy.xml")
    },
  ]
}