data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "api_internal_io_italia_it" {
  name         = replace(local.apim_hostname_api_internal, ".", "-")
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_certificate" "api_app_internal_io_pagopa_it" {
  name         = replace(local.apim_hostname_api_app_internal, ".", "-")
  key_vault_id = var.key_vault.id
}

# data "azurerm_api_management_group" "api_v2_lollipop_assertion_read" {
#   name                = "apilollipopassertionread"
#   api_management_name = module.apim_v2.name
#   resource_group_name = module.apim_v2.resource_group_name
# }

# data "azurerm_api_management_product" "apim_v2_product_lollipop" {
#   product_id          = "io-lollipop-api"
#   api_management_name = module.apim_v2.name
#   resource_group_name = module.apim_v2.resource_group_name
# }
