data "azurerm_resource_group" "weu_common" {
  name = "${local.legacy_project}-rg-common"
}

data "azurerm_key_vault" "weu_common" {
  name                = "${local.legacy_project}-kv-common"
  resource_group_name = data.azurerm_resource_group.weu_common.name
}

data "azurerm_key_vault_secret" "ntfns_common_ntf_common_token" {
  name         = "notification-hub-ntfns-common-ntf-common-token"
  key_vault_id = data.azurerm_key_vault.weu_common.id
}

data "azurerm_key_vault_secret" "ntfns_common_ntf_common_token_sandbox" {
  name         = "notification-hub-ntfns-common-ntf-common-token-sandbox"
  key_vault_id = data.azurerm_key_vault.weu_common.id
}

data "azurerm_key_vault_secret" "ntfns_common_ntf_common_api_key" {
  name         = "notification-hub-ntfns-common-ntf-common-api-key"
  key_vault_id = data.azurerm_key_vault.weu_common.id
}

data "azurerm_key_vault_secret" "ntfns_common_ntf_common_api_key_sandbox" {
  name         = "notification-hub-ntfns-common-ntf-common-api-key-sandbox"
  key_vault_id = data.azurerm_key_vault.weu_common.id
}

data "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = "io-p-rg-common"
  name                = "ioperror"
}
