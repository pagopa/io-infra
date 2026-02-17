data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "proxy_internal_io_pagopa_it" {
  name         = replace(local.proxy_hostname_internal, ".", "-")
  key_vault_id = var.key_vault.id
}

data "azurerm_client_config" "current" {}
