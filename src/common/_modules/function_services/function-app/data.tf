data "azurerm_key_vault" "common" {
  name                = format("%s-kv-common", local.project)
  resource_group_name = local.rg_common_name
}


data "azurerm_key_vault" "io_com" {
  name                = format("%s-com-kv-01", var.project_itn)
  resource_group_name = format("%s-com-rg-01", var.project_itn)
}

########################
# SECRETS
########################
data "azurerm_key_vault_secret" "fn_services_mailup_username" {
  name         = "iocom-MAILUP-USERNAME"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_mailup_secret" {
  name         = "iocom-MAILUP-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_webhook_channel_url" {
  name         = "appbackend-WEBHOOK-CHANNEL-URL"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_sandbox_fiscal_code" {
  name         = "io-SANDBOX-FISCAL-CODE"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_email_service_blacklist_id" {
  name         = "io-EMAIL-SERVICE-BLACKLIST-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_notification_service_blacklist_id" {
  name         = "io-NOTIFICATION-SERVICE-BLACKLIST-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_beta_users" {
  name         = "io-fn-services-BETA-USERS" # common beta list (array of CF)
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_io_service_key" {
  name         = "apim-IO-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_services_pagopa_ecommerce_api_key" {
  name         = "fnservices-PAGOPA-ECOMMERCE-API-KEY-PROD"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "rc_func_key" {
  name         = "rc-func-key"
  key_vault_id = data.azurerm_key_vault.io_com.id
}

########################
# COSMOS
########################
data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.project)
  resource_group_name = local.rg_internal_name
}

data "azurerm_storage_account" "storage_api" {
  name                = replace("${local.project}stapi", "-", "")
  resource_group_name = local.rg_internal_name
}

########################
# NETWORKING
########################

data "azurerm_subnet" "apim_itn_snet" {
  name                 = "io-p-itn-apim-snet-01"
  resource_group_name  = var.common_resource_group_name_itn
  virtual_network_name = var.vnet_common_name_itn
}

data "azurerm_subnet" "private_endpoints_subnet_itn" {
  name                 = "io-p-itn-pep-snet-01"
  virtual_network_name = var.vnet_common_name_itn
  resource_group_name  = var.common_resource_group_name_itn
}

data "azurerm_resource_group" "weu-common" {
  name = "${var.prefix}-${var.env_short}-rg-common"
}

########################
# MONITORING
########################
data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", local.project)
  resource_group_name = local.rg_common_name
}

data "azurerm_monitor_action_group" "error_action_group" {
  name                = "${var.prefix}${var.env_short}error"
  resource_group_name = local.rg_common_name
}

data "azurerm_linux_function_app" "rf_func" {
  name                = format("%s-com-rc-func-01", var.project_itn)
  resource_group_name = format("%s-com-rg-01", var.project_itn)
}
