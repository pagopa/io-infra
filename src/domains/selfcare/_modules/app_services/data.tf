data "azurerm_subnet" "snet_app_gw" {
  name                 = "io-p-appgateway-snet"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}

data "azurerm_subnet" "snet_azdoa" {
  name                 = "azure-devops"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}

data "azurerm_subnet" "services_cms_backoffice_snet" {
  name                 = "${var.project}-services-cms-backoffice-snet"
  virtual_network_name = local.vnet_name_common
  resource_group_name  = local.resource_group_name_common
}

data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", var.project)
  resource_group_name = local.resource_group_name_common
}

data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = "${var.project}-cosmos-api"
  resource_group_name = "${var.project}-rg-internal"
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_key_vault_secret" "selfcare_apim_io_service_key" {
  name         = "apim-IO-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "apim_service_principal_client_id" {
  name         = "devportal-SERVICE-PRINCIPAL-CLIENT-ID"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "apim_service_principal_secret" {
  name         = "devportal-SERVICE-PRINCIPAL-SECRET"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "selfcare_io_sandbox_fiscal_code" {
  name         = "io-SANDBOX-FISCAL-CODE"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "jira_token" {
  name         = "devportal-JIRA-TOKEN"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "selfcare_subsmigrations_apikey" {
  name         = "devportal-subsmigrations-APIKEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportal_client_id" {
  name         = "devportal-CLIENT-ID"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportal_client_secret" {
  name         = "devportal-CLIENT-SECRET"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportal_cookie_iv" {
  name         = "devportal-COOKIE-IV"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportal_cookie_key" {
  name         = "devportal-COOKIE-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "selfcare_devportal_service_principal_secret" {
  name         = "devportal-SERVICE-PRINCIPAL-SECRET"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportal_request_review_legacy_queue_connectionstring" {
  name         = "devportal-REQUEST-REVIEW-LEGACY-QUEUE-CONNECTIONSTRING"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "subscriptionmigrations_db_server_fnsubsmigrations_password" {
  name         = "selfcare-subsmigrations-FNSUBSMIGRATIONS-PASSWORD"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "services_exclusion_list" {
  name         = "io-fn-services-SERVICEID-EXCLUSION-LIST"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportal_io_sandbox_fiscal_code" {
  name         = "io-SANDBOX-FISCAL-CODE"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "devportal_apim_io_service_key" {
  name         = "apim-IO-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_linux_function_app" "webapp_functions_app" {
  name                = "${var.project}-services-cms-webapp-fn"
  resource_group_name = "${var.project}-services-cms-rg"
}

data "azurerm_private_dns_zone" "privatelink_blob_core" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_private_dns_zone" "privatelink_queue_core" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_private_dns_zone" "privatelink_table_core" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_storage_account" "assets_cdn" {
  name                = replace("${var.project}-stcdnassets", "-", "")
  resource_group_name = local.resource_group_name_common
}
