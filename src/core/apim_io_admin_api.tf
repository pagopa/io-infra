# module "apim_product_admin" {
#   source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v4.1.15"

#   product_id            = "io-admin-api"
#   api_management_name   = module.apim.name
#   resource_group_name   = module.apim.resource_group_name
#   display_name          = "IO ADMIN API"
#   description           = "ADMIN API for IO platform."
#   subscription_required = true
#   approval_required     = false
#   published             = true

#   policy_xml = file("./api_product/io_admin/_base_policy.xml")
# }

# # Named Value fn3-admin
# resource "azurerm_api_management_named_value" "io_fn3_admin_url" {
#   name                = "io-fn3-admin-url"
#   api_management_name = module.apim.name
#   resource_group_name = module.apim.resource_group_name
#   display_name        = "io-fn3-admin-url"
#   value               = "https://io-p-admin-fn.azurewebsites.net"
# }

# data "azurerm_key_vault_secret" "io_fn3_admin_key_secret" {
#   name         = "fn3admin-KEY-APIM"
#   key_vault_id = module.key_vault_common.id
# }

# resource "azurerm_api_management_named_value" "io_fn3_admin_key" {
#   name                = "io-fn3-admin-key"
#   api_management_name = module.apim.name
#   resource_group_name = module.apim.resource_group_name
#   display_name        = "io-fn3-admin-key"
#   value               = data.azurerm_key_vault_secret.io_fn3_admin_key_secret.value
#   secret              = "true"
# }

# module "api_admin" {
#   source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v4.1.15"

#   name                = "io-admin-api"
#   api_management_name = module.apim.name
#   resource_group_name = module.apim.resource_group_name
#   revision            = "1"
#   display_name        = "IO ADMIN API"
#   description         = "ADMIN API for IO platform."

#   path        = "adm"
#   protocols   = ["http", "https"]
#   product_ids = [module.apim_product_admin.product_id]

#   service_url = null

#   subscription_required = true

#   content_format = "swagger-json"
#   content_value = templatefile("./api/io_admin/v1/_swagger.json.tpl",
#     {
#       host = "api.io.pagopa.it"
#     }
#   )

#   xml_content = file("./api/io_admin/v1/policy.xml")
# }
