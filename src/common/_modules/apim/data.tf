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
