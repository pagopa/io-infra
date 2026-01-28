data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", var.project_weu_legacy)
  resource_group_name = local.resource_group_name_common
}

data "azurerm_monitor_action_group" "error_action_group" {
  name                = "${replace("${var.project_weu_legacy}", "-", "")}error"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_monitor_action_group" "quarantine_error_action_group" {
  name                = "${replace(var.project_weu_legacy, "-", "")}quarantineerror"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_monitor_action_group" "io_com_action_group" {
  name                = "io-p-com-error-ag-01"
  resource_group_name = "io-p-itn-com-rg-01"
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
  name                = format("%s-cosmos-api", var.project_weu_legacy)
  resource_group_name = format("%s-rg-internal", var.project_weu_legacy)
}

data "azurerm_eventhub_authorization_rule" "evh_ns_io_cosmos_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-evh-ns"
  eventhub_name       = "io-cosmosdb-services"
  resource_group_name = "${var.project_weu_legacy}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pnpg_cosmos_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-messages"
  resource_group_name = "${var.project_weu_legacy}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pdnd_io_cosmos_message_status_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-message-status"
  resource_group_name = "${var.project_weu_legacy}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pdnd_io_cosmos_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-messages"
  resource_group_name = "${var.project_weu_legacy}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pdnd_io_cosmos_service_preferences_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-service-preferences"
  resource_group_name = "${var.project_weu_legacy}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_pdnd_io_cosmos_profiles_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-evh-ns"
  eventhub_name       = "pdnd-io-cosmosdb-profiles"
  resource_group_name = "${var.project_weu_legacy}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_import_command_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-evh-ns"
  eventhub_name       = "import-command"
  resource_group_name = "${var.project_weu_legacy}-evt-rg"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_io_cosmos_profiles_fn" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-evh-ns"
  eventhub_name       = "io-cosmosdb-profiles"
  resource_group_name = "${var.project_weu_legacy}-evt-rg"
}

data "azurerm_subnet" "private_endpoints_subnet_itn" {
  name                 = "io-p-itn-pep-snet-01"
  virtual_network_name = var.vnet_common_name_itn
  resource_group_name  = var.common_resource_group_name_itn
}

data "azurerm_resource_group" "weu-common" {
  name = "${var.prefix}-${var.env_short}-rg-common"
}

// ---------------------
// A&I Event Hub Topic
// ---------------------

data "azurerm_eventhub_authorization_rule" "evh_ns_service_preferences_send_auth_rule" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-itn-auth-elt-evhns-01"
  eventhub_name       = "${var.project_weu_legacy}-itn-auth-elt-service-preferences-01"
  resource_group_name = "${var.project_weu_legacy}-itn-auth-elt-rg-01"
}

data "azurerm_eventhub_authorization_rule" "evh_ns_profiles_send_auth_rule" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-itn-auth-elt-evhns-01"
  eventhub_name       = "${var.project_weu_legacy}-itn-auth-elt-profiles-01"
  resource_group_name = "${var.project_weu_legacy}-itn-auth-elt-rg-01"
}


data "azurerm_eventhub_authorization_rule" "evh_ns_profile_deletion_send_auth_rule" {
  name                = "io-fn-elt"
  namespace_name      = "${var.project_weu_legacy}-itn-auth-elt-evhns-01"
  eventhub_name       = "${var.project_weu_legacy}-itn-auth-elt-profile-deletion-01"
  resource_group_name = "${var.project_weu_legacy}-itn-auth-elt-rg-01"
}

// ---------------------
// /end A&I Event Hub Topic
// ---------------------


data "azurerm_key_vault" "kv_common" {
  name                = "${var.project_weu_legacy}-kv-common"
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
  name                = replace("${var.project_weu_legacy}stapi", "-", "")
  resource_group_name = local.resource_group_name_internal
}

data "azurerm_storage_account" "storage_api_replica" {
  name                = replace("${var.project_weu_legacy}stapireplica", "-", "")
  resource_group_name = local.resource_group_name_internal
}

data "azurerm_storage_account" "storage_assets_cdn" {
  name                = replace(format("%s-stcdnassets", var.project_weu_legacy), "-", "")
  resource_group_name = local.resource_group_name_common
}

data "azurerm_storage_account" "internal_fn" {
  name                = module.function_elt_itn.storage_account.name
  resource_group_name = azurerm_resource_group.itn_elt.name
}

# Citizen-auth domain Redis Common
data "azurerm_redis_cache" "ioauth_redis_common_itn" {
  name                = format("%s-itn-auth-redis-01", var.project_weu_legacy)
  resource_group_name = format("%s-itn-citizen-auth-data-rg-01", var.project_weu_legacy)
}

# Storage Tables

data "azurerm_storage_table" "fnelterrors" {
  name                 = "fnelterrors"
  storage_account_name = module.storage_account_itn_elt.name
}

data "azurerm_storage_table" "fnelterrors_messages" {
  name                 = "fnelterrorsMessages"
  storage_account_name = module.storage_account_itn_elt.name
}

data "azurerm_storage_table" "fnelterrors_message_status" {
  name                 = "fnelterrorsMessageStatus"
  storage_account_name = module.storage_account_itn_elt.name
}

data "azurerm_storage_table" "fneltcommands" {
  name                 = "fneltcommands"
  storage_account_name = module.storage_account_itn_elt.name
}

data "azurerm_storage_table" "fneltexports" {
  name                 = "fneltexports"
  storage_account_name = module.storage_account_itn_elt.name
}

# Storage Containers

data "azurerm_storage_container" "container_messages_report_step1" {
  name                 = "messages-report-step1"
  storage_account_name = module.storage_account_itn_elt.name
}

data "azurerm_storage_container" "container_messages_report_step_final" {
  name                 = "messages-report-step-final"
  storage_account_name = module.storage_account_itn_elt.name
}