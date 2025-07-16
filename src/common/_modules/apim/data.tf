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

data "azurerm_linux_web_app" "cgn_pe_backend_app_01" {
  provider = azurerm.prod-cgn

  name                = "io-p-itn-cgn-pe-backend-app-01"
  resource_group_name = "io-p-itn-cgn-pe-rg-01"
}

data "azurerm_resource_group" "session_manager_rg_weu" {
  name = "io-p-weu-session-manager-rg-01"
}

data "azurerm_linux_web_app" "session_manager_app_weu" {
  name                = "io-p-weu-session-manager-app-03"
  resource_group_name = data.azurerm_resource_group.session_manager_rg_weu.name
}
