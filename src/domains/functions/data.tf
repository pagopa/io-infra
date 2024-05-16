data "azurerm_key_vault" "common" {
  name                = format("%s-kv-common", local.project)
  resource_group_name = local.rg_common_name
}

data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", local.project)
  resource_group_name = local.rg_internal_name
}

data "azurerm_private_dns_zone" "privatelink_blob_core" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = local.rg_internal_name
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

data "azurerm_storage_account" "ioweb_profile" { #TODO
  name                = "ioweb_profile_name"
  resource_group_name = "rg_common_name"
}

###
# kv where the certificate for api-web domain is located
###
data "azurerm_key_vault" "ioweb_kv" {
  name                = format("%s-ioweb-kv", local.project)
  resource_group_name = format("%s-ioweb-sec-rg", local.project)
}