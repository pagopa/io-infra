data "azurerm_key_vault" "common" {
  name                = format("%s-kv-common", local.project)
  resource_group_name = local.rg_common_name
}


data "azurerm_key_vault" "io_com" {
  name                = format("%s-itn-com-kv-01", local.project)
  resource_group_name = format("%s-itn-com-rg-01", local.project)
}

data "azurerm_subnet" "gh_runner" {
  name                 = format("%s-itn-github-runner-snet-01", local.project)
  virtual_network_name = format("%s-itn-common-vnet-01", local.project)
  resource_group_name  = format("%s-itn-common-rg-01", local.project)
}

data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", local.project)
  resource_group_name = local.rg_common_name
}

data "azurerm_private_dns_zone" "privatelink_blob_core" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.rg_common_name
}

data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.project)
  resource_group_name = local.rg_internal_name
}

data "azurerm_monitor_action_group" "error_action_group" {
  name                = "${var.prefix}${var.env_short}error"
  resource_group_name = local.rg_common_name
}

data "azurerm_monitor_action_group" "io_com_action_group" {
  name                = "io-p-com-error-ag-01"
  resource_group_name = "io-p-itn-com-rg-01"
}

data "azurerm_monitor_action_group" "io_auth_error_action_group" {
  name                = "io-p-itn-auth-error-ag-01"
  resource_group_name = "io-p-itn-auth-common-rg-01"
}

data "azurerm_private_dns_zone" "privatelink_queue_core" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = local.rg_common_name
}

data "azurerm_private_dns_zone" "privatelink_table_core" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = local.rg_common_name
}

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.rg_common_name
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

data "azurerm_key_vault" "key_vault_common" {
  name                = "${local.project}-kv-common"
  resource_group_name = local.rg_common_name
}

data "azurerm_key_vault_secret" "fn_app_KEY_SPIDLOGS_PRIV" {
  name         = "funcapp-KEY-SPIDLOGS-PRIV"
  key_vault_id = data.azurerm_key_vault.common.id
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

data "azurerm_subnet" "apim_itn_snet" {
  name                 = "io-p-itn-apim-snet-01"
  resource_group_name  = local.vnet_common_resource_group_name_itn
  virtual_network_name = local.vnet_common_name_itn
}

data "azurerm_subnet" "azdoa_snet" {
  name                 = "azure-devops"
  resource_group_name  = local.rg_common_name
  virtual_network_name = local.vnet_common_name
}

# APIM in ITN
data "azurerm_api_management" "apim_itn_api" {
  name                = local.apim_itn_name
  resource_group_name = local.apim_itn_resource_group_name
}

data "azurerm_linux_function_app" "session_manager_internal" {
  name                = format("%s-weu-auth-sm-int-func-01", local.project)
  resource_group_name = format("%s-auth-main-rg-01", local.common_project_itn)
}

data "azurerm_linux_function_app" "rf_func" {
  name                = format("%s-itn-com-rc-func-01", local.project)
  resource_group_name = format("%s-com-rg-01", local.common_project_itn)
}
