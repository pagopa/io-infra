data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", var.project)
  resource_group_name = local.resource_group_name_common
}

data "azurerm_monitor_action_group" "error_action_group" {
  name                = "${replace("${var.project}", "-", "")}error"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_subnet" "snet_azdoa" {
  name                 = "azure-devops"
  virtual_network_name = var.vnet_name
  resource_group_name  = local.resource_group_name_common
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

data "azurerm_key_vault" "kv_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_key_vault_secret" "services_exclusion_list" {
  name         = "io-fn-services-SERVICEID-EXCLUSION-LIST"
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
