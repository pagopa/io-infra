data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", var.project)
  resource_group_name = local.resource_group_name_common
}

data "azurerm_subnet" "snet_apim_v2" {
  name                 = "apimv2api"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}

data "azurerm_subnet" "snet_azdoa" {
  name                 = "azure-devops"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}

data "azurerm_subnet" "snet_backendl1" {
  name                 = "appbackendl1"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}

data "azurerm_subnet" "snet_backendl2" {
  name                 = "appbackendl2"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}

data "azurerm_subnet" "snet_pblevtdispatcher" {
  name                 = "fnpblevtdispatcherout"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}

data "azurerm_linux_function_app" "function_services" {
  count               = 2
  name                = "${var.project}-services-fn-${count.index + 1}"
  resource_group_name = "${var.project}-services-rg-${count.index + 1}"
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_key_vault" "key_vault" {
  name                = "${var.project}-kv"
  resource_group_name = local.resource_group_name_sec
}

data "azurerm_key_vault_secret" "fn_eucovidcert_API_KEY_APPBACKEND" {
  name         = "funceucovidcert-KEY-APPBACKEND"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_API_KEY_PUBLICIOEVENTDISPATCHER" {
  name         = "funceucovidcert-KEY-PUBLICIOEVENTDISPATCHER"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_PROD_CLIENT_CERT" {
  name         = "eucovidcert-DGC-PROD-CLIENT-CERT"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_PROD_CLIENT_KEY" {
  name         = "eucovidcert-DGC-PROD-CLIENT-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_PROD_SERVER_CA" {
  name         = "eucovidcert-DGC-PROD-SERVER-CA"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_UAT_CLIENT_CERT" {
  name         = "eucovidcert-DGC-UAT-CLIENT-CERT"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_UAT_CLIENT_KEY" {
  name         = "eucovidcert-DGC-UAT-CLIENT-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_UAT_SERVER_CA" {
  name         = "eucovidcert-DGC-UAT-SERVER-CA"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_LOAD_TEST_CLIENT_KEY" {
  name         = "eucovidcert-DGC-LOAD-TEST-CLIENT-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_LOAD_TEST_CLIENT_CERT" {
  name         = "eucovidcert-DGC-LOAD-TEST-CLIENT-CERT"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_DGC_LOAD_TEST_SERVER_CA" {
  name         = "eucovidcert-DGC-LOAD-TEST-SERVER-CA"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_eucovidcert_FNSERVICES_API_KEY" {
  name         = "fn3services-KEY-EUCOVIDCERT"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_monitor_action_group" "error_action_group" {
  name                = "${replace("${var.project}", "-", "")}error"
  resource_group_name = local.resource_group_name_common
}
