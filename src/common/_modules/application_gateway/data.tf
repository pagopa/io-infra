#######################
### Web Application ###
#######################

data "azurerm_linux_web_app" "cms_backoffice_app_itn" {
  name                = "${var.project}-itn-svc-bo-app-01"
  resource_group_name = "${var.project}-itn-svc-rg-01"
}

data "azurerm_linux_web_app" "appservice_continua" {
  name                = "${var.project}-app-continua"
  resource_group_name = "${var.project}-continua-rg"
}

data "azurerm_linux_web_app" "session_manager_03" {
  name                = "io-p-weu-session-manager-app-03"
  resource_group_name = "io-p-weu-session-manager-rg-01"
}

data "azurerm_linux_web_app" "fims_op_app" {
  name                = "io-p-itn-fims-op-app-01"
  resource_group_name = "io-p-itn-fims-rg-01"
}

data "azurerm_linux_web_app" "appservice_devportal_be" {
  name                = "${var.project}-app-devportal-be"
  resource_group_name = "${var.project}-selfcare-be-rg"
}

data "azurerm_linux_web_app" "ipatente_vehicles_app_itn" {
  name                = "${var.project}-itn-ipatente-vehicles-app-01"
  resource_group_name = "${var.project}-itn-ipatente-rg-01"
}

data "azurerm_linux_web_app" "ipatente_licences_app_itn" {
  name                = "${var.project}-itn-ipatente-licences-app-01"
  resource_group_name = "${var.project}-itn-ipatente-rg-01"
}

data "azurerm_linux_web_app" "ipatente_payments_app_itn" {
  name                = "${var.project}-itn-ipatente-payments-app-01"
  resource_group_name = "${var.project}-itn-ipatente-rg-01"
}

data "azurerm_linux_web_app" "ipatente_practices_app_itn" {
  name                = "${var.project}-itn-ipatente-practices-app-01"
  resource_group_name = "${var.project}-itn-ipatente-rg-01"
}

#######################
###    Key Vault    ###
#######################

data "azurerm_key_vault_certificate" "app_gw_api" {
  name         = var.certificates.api
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_api_mtls" {
  name         = var.certificates.api_mtls
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_api_app" {
  name         = var.certificates.api_app
  key_vault_id = var.key_vault.id
}

###
# kv where the certificate for api-web domain is located
###
data "azurerm_key_vault" "ioweb_kv" {
  name                = format("%s-ioweb-kv", var.project)
  resource_group_name = format("%s-ioweb-sec-rg", var.project)
}

data "azurerm_key_vault_certificate" "app_gw_api_web" {
  name         = var.certificates.api_web
  key_vault_id = data.azurerm_key_vault.ioweb_kv.id
}

data "azurerm_key_vault_certificate" "app_gw_api_io_italia_it" {
  name         = var.certificates.api_io_italia_it
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_certificate" "app_gw_app_backend_io_italia_it" {
  name         = var.certificates.app_backend_io_italia_it
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_certificate" "app_gw_developerportal_backend_io_italia_it" {
  name         = var.certificates.developerportal_backend_io_italia_it
  key_vault_id = var.key_vault_common.id
}

data "azurerm_key_vault_certificate" "app_gw_firmaconio_selfcare_pagopa_it" {
  name         = var.certificates.firmaconio_selfcare_pagopa_it
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_continua" {
  name         = var.certificates.continua_io_pagopa_it
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_oauth" {
  name         = var.certificates.oauth_io_pagopa_it
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_selfcare_io" {
  name         = var.certificates.selfcare_io_pagopa_it
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_vehicles_ipatente_io" {
  name         = var.certificates.vehicles_ipatente_io_pagopa_it
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_licences_ipatente_io" {
  name         = var.certificates.licences_ipatente_io_pagopa_it
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_payments_ipatente_io" {
  name         = var.certificates.payments_ipatente_io_pagopa_it
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_certificate" "app_gw_practices_ipatente_io" {
  name         = var.certificates.practices_ipatente_io_pagopa_it
  key_vault_id = var.key_vault.id
}

data "azurerm_key_vault_secret" "app_gw_mtls_header_name" {
  name         = "mtls-header-name"
  key_vault_id = var.key_vault.id
}
