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

###############
# FOR TESTING #
###############

data "azurerm_private_dns_zone" "azure_api_net" {
  count = var.migration ? 1 : 0

  name                = "azure-api.net"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "management_azure_api_net" {
  count = var.migration ? 1 : 0

  name                = "management.azure-api.net"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_private_dns_zone" "scm_azure_api_net" {
  count = var.migration ? 1 : 0

  name                = "scm.azure-api.net"
  resource_group_name = "io-p-rg-common"
}

data "azurerm_linux_web_app" "cgn_pe_backend_app_01" {
  provider = azurerm.prod-cgn

  name                = "io-p-itn-cgn-pe-backend-app-01"
  resource_group_name = "io-p-itn-cgn-pe-rg-01"
}
