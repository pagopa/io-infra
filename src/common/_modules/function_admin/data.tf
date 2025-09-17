data "azurerm_resource_group" "admin_itn_rg" {
  name = "${var.project_itn}-funcadm-rg-01"
}

# APIM in ITN
data "azurerm_api_management" "apim_itn_api" {
  name                = local.apim_itn_name
  resource_group_name = local.common_resource_group_name_itn
}

data "azurerm_resource_group" "weu-common" {
  name = "${var.prefix}-${var.env_short}-rg-common"
}

data "azurerm_subnet" "private_endpoints_subnet_itn" {
  name                 = "io-p-itn-pep-snet-01"
  virtual_network_name = var.vnet_common_name_itn
  resource_group_name  = var.common_resource_group_name_itn
}


#
# SECRETS
#

data "azurerm_key_vault" "common" {
  name                = format("%s-kv-common", local.project)
  resource_group_name = local.rg_common_name
}

data "azurerm_key_vault_secret" "fn_admin_ASSETS_URL" {
  name         = "cdn-ASSETS-URL"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_admin_AZURE_SUBSCRIPTION_ID" {
  name         = "common-AZURE-SUBSCRIPTION-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_admin_INSTANT_DELETE_ENABLED_USERS" {
  name         = "fn-admin-INSTANT-DELETE-ENABLED-USERS"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "adb2c_TENANT_NAME" {
  name         = "adb2c-TENANT-NAME"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_CLIENT_ID" {
  name         = "devportal-CLIENT-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "devportal_CLIENT_SECRET" {
  name         = "devportal-CLIENT-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "adb2c_TOKEN_ATTRIBUTE_NAME" {
  name         = "adb2c-TOKEN-ATTRIBUTE-NAME"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "ad_APPCLIENT_APIM_ID" {
  name         = "ad-APPCLIENT-APIM-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "ad_APPCLIENT_APIM_SECRET" {
  name         = "ad-APPCLIENT-APIM-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "common_AZURE_TENANT_ID" {
  name         = "common-AZURE-TENANT-ID"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "apim_IO_GDPR_SERVICE_KEY" {
  name         = "apim-IO-GDPR-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "common_SENDGRID_APIKEY" {
  name         = "common-SENDGRID-APIKEY"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_admin_SESSION_MANAGER_INTERNAL_KEY" {
  name         = "fn-admin-session-manager-internal-key"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "fn_app_KEY_SPIDLOGS_PRIV" {
  name         = "funcapp-KEY-SPIDLOGS-PRIV"
  key_vault_id = data.azurerm_key_vault.common.id
}

#
# Storage 
#

data "azurerm_storage_account" "userdatadownload" {
  name                = "iopstuserdatadownload"
  resource_group_name = local.rg_internal_name
}

data "azurerm_storage_account" "userbackups" {
  name                = "iopstuserbackups"
  resource_group_name = local.rg_internal_name
}

data "azurerm_storage_account" "storage_api" {
  name                = replace("${local.project}stapi", "-", "")
  resource_group_name = local.rg_internal_name
}

data "azurerm_storage_account" "assets_cdn" {
  name                = replace("${local.project}-stcdnassets", "-", "")
  resource_group_name = local.rg_common_name
}

data "azurerm_storage_account" "logs02" {
  name                = replace("${local.project}-stlogs02", "-", "")
  resource_group_name = "${local.project}-rg-operations"
}

data "azurerm_storage_account" "ioweb_spid_logs_storage" {
  name                = "iopweuiowebspidlogsimst"
  resource_group_name = "io-p-weu-ioweb-storage-rg"
}

data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.project)
  resource_group_name = local.rg_internal_name
}

#
# UNIQUE EMAIL ENFORCEMENT
#
# TODO: Remove when switch to new itn storage account is done

data "azurerm_storage_account" "citizen_auth_common" {
  name                = "iopweucitizenauthst"
  resource_group_name = "io-p-citizen-auth-data-rg"
}

data "azurerm_storage_account" "auth_maintenance_storage" {
  name                = replace(format("%s-itn-auth-mnt-st-01", local.project), "-", "")
  resource_group_name = format("%s-itn-auth-main-rg-01", local.project)
}

#
# Notifications resources
#

data "azurerm_storage_account" "locked_profiles_storage" {
  name                = replace(format("%s-locked-profiles-st", local.project), "-", "")
  resource_group_name = local.rg_internal_name
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

data "azurerm_monitor_action_group" "io_com_action_group" {
  name                = "io-p-com-error-ag-01"
  resource_group_name = "io-p-itn-com-rg-01"
}

data "azurerm_linux_function_app" "session_manager_internal" {
  name                = format("%s-weu-auth-sm-int-func-01", local.project)
  resource_group_name = format("%s-auth-main-rg-01", var.project_itn)
}

data "azurerm_monitor_action_group" "io_auth_error_action_group" {
  name                = "io-p-itn-auth-error-ag-01"
  resource_group_name = "io-p-itn-auth-common-rg-01"
}

# MAILUP

data "azurerm_key_vault_secret" "common_MAILUP_USERNAME" {
  name         = "common-MAILUP-AI-USERNAME"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "common_MAILUP_SECRET" {
  name         = "common-MAILUP-AI-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}
