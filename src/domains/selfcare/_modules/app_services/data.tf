data "azurerm_subnet" "snet_app_gw" {
  name                 = "io-p-appgateway-snet"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}

data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", var.project)
  resource_group_name = local.resource_group_name_common
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_key_vault_secret" "selfcare_apim_io_service_key" {
  name         = "apim-IO-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "selfcare_devportal_service_principal_client_id" {
  name         = "devportal-SERVICE-PRINCIPAL-CLIENT-ID"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "selfcare_devportal_service_principal_secret" {
  name         = "devportal-SERVICE-PRINCIPAL-SECRET"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "selfcare_io_sandbox_fiscal_code" {
  name         = "io-SANDBOX-FISCAL-CODE"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "selfcare_devportal_jira_token" {
  name         = "devportal-JIRA-TOKEN"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "selfcare_subsmigrations_apikey" {
  name         = "devportal-subsmigrations-APIKEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportal_request_review_legacy_queue_connectionstring" {
  name         = "devportal-REQUEST-REVIEW-LEGACY-QUEUE-CONNECTIONSTRING"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_linux_function_app" "webapp_functions_app" {
  name                = "${var.project}-services-cms-webapp-fn"
  resource_group_name = "${var.project}-services-cms-rg"
}

data "azurerm_linux_function_app" "fn_subscription_migration" {
  name                = "${var.project}-subsmigrations-fn"
  resource_group_name = "${var.project}-selfcare-be-rg"
}
