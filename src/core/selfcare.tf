### Common resources

locals {
  selfcare_io = {
    backend_hostname  = "api.${var.dns_zone_io_selfcare}.${var.external_domain}"
    frontend_hostname = "${var.dns_zone_io_selfcare}.${var.external_domain}"
  }

  selfcare = {
    hostname = "${var.selfcare_external_hostname}"
  }
}

### Frontend common resources
# data "azurerm_resource_group" "selfcare_fe_rg" {
#   name = "${local.project}-selfcare-fe-rg"
# }

### Backend common resources
data "azurerm_resource_group" "selfcare_be_rg" {
  name = format("%s-selfcare-be-rg", local.project)
}

data "azurerm_dns_a_record" "selfcare_cdn" {
  name                = "@"
  resource_group_name = azurerm_dns_zone.io_selfcare_pagopa_it[0].resource_group_name
  zone_name           = azurerm_dns_zone.io_selfcare_pagopa_it[0].name
}

## key vault

# data "azurerm_key_vault_secret" "selfcare_apim_io_service_key" {
#   name         = "apim-IO-SERVICE-KEY"
#   key_vault_id = module.key_vault_common.id
# }

# data "azurerm_key_vault_secret" "selfcare_devportal_service_principal_client_id" {
#   name         = "devportal-SERVICE-PRINCIPAL-CLIENT-ID"
#   key_vault_id = module.key_vault_common.id
# }

# data "azurerm_key_vault_secret" "selfcare_devportal_service_principal_secret" {
#   name         = "devportal-SERVICE-PRINCIPAL-SECRET"
#   key_vault_id = module.key_vault_common.id
# }

# data "azurerm_key_vault_secret" "selfcare_io_sandbox_fiscal_code" {
#   name         = "io-SANDBOX-FISCAL-CODE"
#   key_vault_id = module.key_vault_common.id
# }

# data "azurerm_key_vault_secret" "selfcare_devportal_jira_token" {
#   name         = "devportal-JIRA-TOKEN"
#   key_vault_id = module.key_vault_common.id
# }

# data "azurerm_key_vault_secret" "selfcare_subsmigrations_apikey" {
#   name         = "devportal-subsmigrations-APIKEY"
#   key_vault_id = module.key_vault_common.id
# }


data "azurerm_subnet" "selfcare_be_common_snet" {
  name                 = format("%s-selfcare-be-common-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = module.vnet_common.name
}
