resource "azurerm_resource_group" "data" {
  name     = format("%s-data-rg", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

data "azurerm_redis_cache" "redis_common" {
  name                = format("%s-redis-common", local.project)
  resource_group_name = format("%s-rg-common", local.project)
}

#
# Function apps resources
#

data "azurerm_function_app" "fnapp_app1" {
  name                = format("%s-fn3-app1", local.project)
  resource_group_name = format("%s-rg-functions_app1", local.project)
}

data "azurerm_function_app" "fnapp_app2" {
  name                = format("%s-fn3-app2", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

data "azurerm_function_app" "fnapp_appasync" {
  name                = format("%s-fn3-appasync", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

#
# Function services resources
#

data "azurerm_function_app" "fnapp_services" {
  name                = format("%s-fn3-services", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

data "azurerm_subnet" "fnapp_services_subnet_out" {
  name                 = "fn3services"
  virtual_network_name = format("%s-vnet-common", local.project)
  resource_group_name  = format("%s-rg-common", local.project)
}

#
# Function admin resources
#

data "azurerm_function_app" "fnapp_admin" {
  name                = format("%s-fn3-admin", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

data "azurerm_subnet" "fnapp_admin_subnet_out" {
  name                 = "fn3admin"
  virtual_network_name = format("%s-vnet-common", local.project)
  resource_group_name  = format("%s-rg-common", local.project)
}

#
# pagoPA proxy resources
#

data "azurerm_app_service" "pagopa_proxy_prod" {
  name                = format("%s-app-pagopaproxyprod", local.project)
  resource_group_name = format("%s-rg-external", local.project)
}

data "azurerm_app_service" "pagopa_proxy_test" {
  name                = format("%s-app-pagopaproxytest", local.project)
  resource_group_name = format("%s-rg-external", local.project)
}

#
# CGN resources
#

data "azurerm_function_app" "fnapp_cgn" {
  name                = format("%s-func-cgn", local.project)
  resource_group_name = format("%s-rg-cgn", local.project)
}

#
# Bonus vacanze resources
#

data "azurerm_function_app" "fnapp_bonus" {
  name                = format("%s-func-bonus", local.project)
  resource_group_name = format("%s-rg-internal", local.project)
}

#
# EUCovicCert resources
#

data "azurerm_function_app" "fnapp_eucovidcert" {
  name                = format("%s-fn3-eucovidcert", local.project)
  resource_group_name = format("%s-rg-eucovidcert", local.project)
}

data "azurerm_key_vault_secret" "fnapp_eucovidcert_authtoken" {
  name         = "funceucovidcert-KEY-PUBLICIOEVENTDISPATCHER"
  key_vault_id = module.key_vault.id
}

#
# logs resources
#

data "azurerm_storage_account" "logs" {
  name                = replace(format("%s-stlogs", local.project), "-", "")
  resource_group_name = format("%s-rg-operations", local.project)
}

# todo migrate storage account and related resources
locals {
  storage_account_notifications_queue_spidmsgitems = "spidmsgitems"
  storage_account_notifications_queue_userslogin   = "userslogin"
}

#
# Notifications resources
#

data "azurerm_storage_account" "notifications" {
  name                = replace(format("%s-stnotifications", local.project), "-", "")
  resource_group_name = format("%s-rg-internal", local.project)
}

# todo migrate storage account and related resources
locals {
  storage_account_notifications_queue_push_notifications = "push-notifications"
}

#
# Private subnet
#

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = format("%s-vnet-common", local.project)
  resource_group_name  = format("%s-rg-common", local.project)
}

#
# Private dns zones
#

data "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

data "azurerm_private_dns_zone" "privatelink_queue_core_windows_net" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

data "azurerm_private_dns_zone" "privatelink_file_core_windows_net" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}

data "azurerm_private_dns_zone" "privatelink_table_core_windows_net" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = format("%s-rg-common", local.project)
}