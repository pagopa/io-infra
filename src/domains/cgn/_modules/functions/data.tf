data "azurerm_application_insights" "application_insights" {
  name                = format("%s-ai-common", var.project)
  resource_group_name = "${var.project}-rg-common"
}

data "azurerm_subnet" "snet_apim_v2" {
  name                 = "apimv2api"
  virtual_network_name = "${var.project}-vnet-common"
  resource_group_name  = "${var.project}-rg-common"
}

data "azurerm_subnet" "snet_azdoa" {
  name                 = "azure-devops"
  virtual_network_name = "${var.project}-vnet-common"
  resource_group_name  = "${var.project}-rg-common"
}

data "azurerm_subnet" "snet_backendl1" {
  name                 = "appbackendl1"
  virtual_network_name = "${var.project}-vnet-common"
  resource_group_name  = "${var.project}-rg-common"
}

data "azurerm_subnet" "snet_backendl2" {
  name                 = "appbackendl2"
  virtual_network_name = "${var.project}-vnet-common"
  resource_group_name  = "${var.project}-rg-common"
}

data "azurerm_subnet" "snet_backendli" {
  name                 = "appbackendli"
  virtual_network_name = "${var.project}-vnet-common"
  resource_group_name  = "${var.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_blob_core" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "${var.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_queue_core" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = "${var.project}-rg-common"
}

data "azurerm_private_dns_zone" "privatelink_table_core" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = "${var.project}-rg-common"
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = "${var.project}-rg-common"
}

data "azurerm_key_vault_secret" "fn_cgn_SERVICES_API_KEY" {
  name         = "apim-CGN-SERVICE-KEY"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_cgn_EYCA_API_USERNAME" {
  name         = "funccgn-EYCA-API-USERNAME"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_cgn_EYCA_API_PASSWORD" {
  name         = "funccgn-EYCA-API-PASSWORD"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_cgn_CGN_SERVICE_ID" {
  name         = "funccgn-CGN-SERVICE-ID"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_key_vault_secret" "fn_cgn_CGN_DATA_BACKUP_CONNECTION" {
  name         = "cgn-legalbackup-storage-connection-string"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}

data "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = "${var.project}-rg-common"
  name                = "${replace("${var.project}", "-", "")}error"
}
