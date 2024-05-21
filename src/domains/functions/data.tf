data "azurerm_key_vault" "common" {
  name                = format("%s-kv-common", local.project)
  resource_group_name = local.rg_common_name
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

data "azurerm_virtual_network" "vnet_common" {
  name                = format("%s-vnet-common", local.project)
  resource_group_name = local.rg_common_name
}

data "azurerm_monitor_action_group" "error_action_group" {
  name                = "${var.prefix}${var.env_short}error"
  resource_group_name = local.rg_common_name
}

data "azurerm_subnet" "ioweb_profile_snet" {
  name                 = format("%s-%s-ioweb-profile-snet", local.project, var.location_short)
  virtual_network_name = local.vnet_common_name
  resource_group_name  = local.rg_common_name
}

data "azurerm_private_dns_zone" "privatelink_queue_core" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = local.rg_common_name
}

data "azurerm_private_dns_zone" "privatelink_table_core" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = local.rg_common_name
}

###
# kv where the certificate for api-web domain is located
###
data "azurerm_key_vault" "ioweb_kv" {
  name                = format("%s-ioweb-kv", local.project)
  resource_group_name = format("%s-ioweb-sec-rg", local.project)
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

data "azurerm_key_vault" "key_vault_common" {
  name                = "${local.project}-kv-common"
  resource_group_name = local.rg_common_name
}


data "azurerm_key_vault_secret" "app_backend_PRE_SHARED_KEY" {
  name         = "appbackend-PRE-SHARED-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

# MAILUP

data "azurerm_key_vault_secret" "common_MAILUP_USERNAME" {
  name         = "common-MAILUP2-USERNAME"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_key_vault_secret" "common_MAILUP_SECRET" {
  name         = "common-MAILUP2-SECRET"
  key_vault_id = data.azurerm_key_vault.common.id
}

#
# UNIQUE EMAIL ENFORCEMENT
#

data "azurerm_storage_account" "citizen_auth_common" {
  name                = "iopweucitizenauthst"
  resource_group_name = "io-p-citizen-auth-data-rg"
}

#
# Logs resources
#

data "azurerm_storage_account" "logs" {
  name                = replace(format("%s-stlogs", local.project), "-", "")
  resource_group_name = format("%s-rg-operations", local.project)
}

#
# Notifications resources
#

data "azurerm_resource_group" "notifications_rg" {
  name = format("%s-weu-messages-notifications-rg", local.project)
}

data "azurerm_storage_account" "push_notifications_storage" {
  name                = replace(format("%s-weu-messages-notifst", local.project), "-", "")
  resource_group_name = data.azurerm_resource_group.notifications_rg.name
}

data "azurerm_storage_account" "notifications" {
  name                = replace(format("%s-stnotifications", local.project), "-", "")
  resource_group_name = format("%s-rg-internal", local.project)
}

data "azurerm_app_service" "appservice_app_backendli" {
  name                = format("%s-app-appbackendli", local.project)
  resource_group_name = format("%s-rg-linux", local.project)
}

data "azurerm_storage_account" "locked_profiles_storage" {
  name                = replace(format("%s-locked-profiles-st", local.project), "-", "")
  resource_group_name = local.rg_internal_name
}

data "azurerm_storage_account" "storage_apievents" {
  name                = replace(format("%s-stapievents", local.project), "-", "")
  resource_group_name = local.rg_internal_name
}

data "azurerm_key_vault_secret" "app_backend_UNIQUE_EMAIL_ENFORCEMENT_USER" {
  name         = "appbackend-UNIQUE-EMAIL-ENFORCEMENT-USER"
  key_vault_id = data.azurerm_key_vault.common.id
}

data "azurerm_subnet" "function_eucovidcert_snet" {
  name                 = format("%s-eucovidcert-snet", local.project)
  resource_group_name  = local.rg_common_name
  virtual_network_name = local.vnet_common_name
}

data "azurerm_subnet" "apim_v2_snet" {
  name                 = "apimv2api"
  resource_group_name  = local.rg_common_name
  virtual_network_name = local.vnet_common_name
}

data "azurerm_subnet" "azdoa_snet" {
  name                 = "azure-devops"
  resource_group_name  = local.rg_common_name
  virtual_network_name = local.vnet_common_name
}

data "azurerm_subnet" "app_backendli_snet" {
  name                 = "appbackendli"
  resource_group_name  = local.rg_common_name
  virtual_network_name = local.vnet_common_name
}

data "azurerm_subnet" "app_backendl1_snet" {
  name                 = "appbackendl1"
  resource_group_name  = local.rg_common_name
  virtual_network_name = local.vnet_common_name
}

data "azurerm_subnet" "app_backendl2_snet" {
  name                 = "appbackendl2"
  resource_group_name  = local.rg_common_name
  virtual_network_name = local.vnet_common_name
}
