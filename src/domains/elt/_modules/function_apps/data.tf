data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", var.project)
  resource_group_name = local.resource_group_name_common
}

data "azurerm_monitor_action_group" "error_action_group" {
  name                = "${replace("${var.project}", "-", "")}error"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_monitor_action_group" "quarantine_error_action_group" {
  name                = "${replace(var.project, "-", "")}quarantineerror"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_monitor_action_group" "io_com_action_group" {
  name                = "io-p-com-error-ag-01"
  resource_group_name = "io-p-itn-com-rg-01"
}

data "azurerm_subnet" "gh_runner" {
  name                 = format("%s-itn-github-runner-snet-01", var.project)
  virtual_network_name = format("%s-itn-common-vnet-01", var.project)
  resource_group_name  = format("%s-itn-common-rg-01", var.project)
}

data "azurerm_subnet" "private_endpoints_subnet" {
  name                 = "pendpoints"
  virtual_network_name = var.vnet_name
  resource_group_name  = local.resource_group_name_common
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

data "azurerm_cosmosdb_account" "cosmos_api" {
  name                = format("%s-cosmos-api", var.project)
  resource_group_name = format("%s-rg-internal", var.project)
}

data "azurerm_eventhub_authorization_rule" "evh_ns_io_cosmos_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-evh-ns"
  eventhub_name       = "io-cosmosdb-services"
  resource_group_name = "${var.project}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pnpg_cosmos_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-messages"
  resource_group_name = "${var.project}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pdnd_io_cosmos_notification_status_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-notification-status"
  resource_group_name = "${var.project}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pdnd_io_cosmos_message_status_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-message-status"
  resource_group_name = "${var.project}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pdnd_io_cosmos_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-messages"
  resource_group_name = "${var.project}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pdnd_io_cosmos_service_preferences_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-service-preferences"
  resource_group_name = "${var.project}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pdnd_io_cosmos_profiles_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-profiles"
  resource_group_name = "${var.project}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_import_command_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-evh-ns"
  eventhub_name       = "import-command"
  resource_group_name = "${var.project}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_io_cosmos_profiles_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-evh-ns"
  eventhub_name       = "io-cosmosdb-profiles"
  resource_group_name = "${var.project}-evt-rg"
}

// ---------------------
// A&I Event Hub Topic
// ---------------------

data "azurerm_eventhub_authorization_rule" "evh_ns_service_preferences_send_auth_rule" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-itn-auth-elt-evhns-01"
  eventhub_name       = "${var.project}-itn-auth-elt-service-preferences-01"
  resource_group_name = "${var.project}-itn-auth-elt-rg-01"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_profiles_send_auth_rule" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-itn-auth-elt-evhns-01"
  eventhub_name       = "${var.project}-itn-auth-elt-profiles-01"
  resource_group_name = "${var.project}-itn-auth-elt-rg-01"
}


data "azurerm_eventhub_authorization_rule" "evh_ns_profile_deletion_send_auth_rule" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project}-itn-auth-elt-evhns-01"
  eventhub_name       = "${var.project}-itn-auth-elt-profile-deletion-01"
  resource_group_name = "${var.project}-itn-auth-elt-rg-01"
}

// ---------------------
// /end A&I Event Hub Topic
// ---------------------


data "azurerm_key_vault" "kv_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_key_vault_secret" "services_exclusion_list" {
  name         = "io-fn-services-SERVICEID-EXCLUSION-LIST"
  key_vault_id = data.azurerm_key_vault.kv_common.id
}

data "azurerm_key_vault_secret" "pdv_tokenizer_api_key" {
  name         = "func-elt-PDV-TOKENIZER-API-KEY"
  key_vault_id = data.azurerm_key_vault.kv_common.id
}

data "azurerm_storage_account" "storage_api" {
  name                = replace("${var.project}stapi", "-", "")
  resource_group_name = local.resource_group_name_internal
}

data "azurerm_storage_account" "storage_api_replica" {
  name                = replace("${var.project}stapireplica", "-", "")
  resource_group_name = local.resource_group_name_internal
}

data "azurerm_storage_account" "storage_assets_cdn" {
  name                = replace(format("%s-stcdnassets", var.project), "-", "")
  resource_group_name = local.resource_group_name_common
}

data "azurerm_storage_account" "function_elt_internal_storage" {
  name                = module.function_elt.storage_account_internal_function_name
  resource_group_name = var.resource_group_name
}

# Citizen-auth domain Redis Common
data "azurerm_redis_cache" "ioauth_redis_common_itn" {
  name                = format("%s-itn-auth-redis-01", var.project)
  resource_group_name = format("%s-itn-citizen-auth-data-rg-01", var.project)
}
