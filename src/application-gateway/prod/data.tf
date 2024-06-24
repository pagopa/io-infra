data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "weu_common" {
  name = "${local.project}-rg-common"
}

data "azurerm_resource_group" "weu_sec" {
  name = "${local.project}-sec-rg"
}

data "azurerm_resource_group" "weu_external" {
  name = "${local.project}-rg-external"
}

data "azurerm_virtual_network" "weu_common" {
  name                = "${local.project}-vnet-common"
  resource_group_name = data.azurerm_resource_group.weu_common.name
}

data "azurerm_key_vault" "weu_common" {
  name                = "${local.project}-kv-common"
  resource_group_name = data.azurerm_resource_group.weu_common.name
}

data "azurerm_key_vault" "weu" {
  name                = "${local.project}-kv"
  resource_group_name = data.azurerm_resource_group.weu_sec.name
}

## user assined identity: (old application gateway) ##
data "azuread_service_principal" "app_gw_uai_kvreader" {
  display_name = format("%s-uai-kvreader", local.project)
}

data "azurerm_key_vault_certificate" "app_gw_api" {
  name         = "api-io-pagopa-it"
  key_vault_id = data.azurerm_key_vault.weu.id
}

data "azurerm_key_vault_certificate" "app_gw_api_mtls" {
  name         = "api-mtls-io-pagopa-it"
  key_vault_id = data.azurerm_key_vault.weu.id
}

data "azurerm_key_vault_certificate" "app_gw_api_app" {
  name         = "api-app-io-pagopa-it"
  key_vault_id = data.azurerm_key_vault.weu.id
}

###
# kv where the certificate for api-web domain is located
###
data "azurerm_key_vault" "ioweb_kv" {
  name                = format("%s-ioweb-kv", local.project)
  resource_group_name = format("%s-ioweb-sec-rg", local.project)
}

data "azurerm_key_vault_certificate" "app_gw_api_web" {
  name         = "api-web-io-pagopa-it"
  key_vault_id = data.azurerm_key_vault.ioweb_kv.id
}
###

data "azurerm_key_vault_certificate" "app_gw_api_io_italia_it" {
  name         = "api-io-italia-it"
  key_vault_id = data.azurerm_key_vault.weu_common.id
}

data "azurerm_key_vault_certificate" "app_gw_app_backend_io_italia_it" {
  name         = "app-backend-io-italia-it"
  key_vault_id = data.azurerm_key_vault.weu_common.id
}

data "azurerm_key_vault_certificate" "app_gw_developerportal_backend_io_italia_it" {
  name         = "developerportal-backend-io-italia-it"
  key_vault_id = data.azurerm_key_vault.weu_common.id
}

data "azurerm_key_vault_certificate" "app_gw_api_io_selfcare_pagopa_it" {
  name         = "api-io-selfcare-pagopa-it"
  key_vault_id = data.azurerm_key_vault.weu.id
}

data "azurerm_key_vault_certificate" "app_gw_firmaconio_selfcare_pagopa_it" {
  name         = "firmaconio-selfcare-pagopa-it"
  key_vault_id = data.azurerm_key_vault.weu.id
}

data "azurerm_key_vault_certificate" "app_gw_continua" {
  name         = "continua-io-pagopa-it"
  key_vault_id = data.azurerm_key_vault.weu.id
}

data "azurerm_key_vault_certificate" "app_gw_selfcare_io" {
  name         = "selfcare-io-pagopa-it"
  key_vault_id = data.azurerm_key_vault.weu.id
}

data "azurerm_key_vault_certificate" "app_gw_openid_provider_io" {
  name         = "openid-provider-io-pagopa-it"
  key_vault_id = data.azurerm_key_vault.weu.id
}

data "azurerm_key_vault_secret" "app_gw_mtls_header_name" {
  name         = "mtls-header-name"
  key_vault_id = data.azurerm_key_vault.weu.id
}

data "azurerm_linux_web_app" "backendl1" {
  name                = "${local.project}-app-appbackendl1"
  resource_group_name = "${local.project}-rg-linux"
}

data "azurerm_linux_web_app" "backendl2" {
  name                = "${local.project}-app-appbackendl2"
  resource_group_name = "${local.project}-rg-linux"
}

data "azurerm_linux_web_app" "appservice_devportal_be" {
  name                = "${local.project}-app-devportal-be"
  resource_group_name = "${local.project}-selfcare-be-rg"
}

data "azurerm_linux_web_app" "appservice_selfcare_be" {
  name                = "${local.project}-app-selfcare-be"
  resource_group_name = "${local.project}-selfcare-be-rg"
}

data "azurerm_linux_web_app" "firmaconio_selfcare_web_app" {
  name                = format("%s-backoffice-app", local.firmaconio_project)
  resource_group_name = local.firmaconio.resource_group_names.backend
}

data "azurerm_linux_web_app" "appservice_continua" {
  name                = "${local.project}-app-continua"
  resource_group_name = "${local.project}-continua-rg"
}

data "azurerm_linux_web_app" "cms_backoffice_app" {
  name                = format("%s-services-cms-backoffice-app", local.project)
  resource_group_name = format("%s-services-cms-rg", local.project)
}

data "azurerm_linux_web_app" "session_manager" {
  name                = "${local.project}-weu-session-manager-app-03"
  resource_group_name = "${local.project}-weu-session-manager-rg-01"
}

data "azurerm_linux_web_app" "fims_op_app" {
  name                = "${local.project}-weu-fims-op-app-01"
  resource_group_name = "${local.project}-weu-fims-rg-01"
}

data "azurerm_monitor_action_group" "error_action_group" {
  name                = format("%s%serror", local.prefix, local.env_short)
  resource_group_name = data.azurerm_resource_group.weu_common.name
}
