data "azurerm_api_management" "apim" {
  name                = var.apim.name
  resource_group_name = var.apim.resource_group_name
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}

data "azurerm_key_vault_secret" "io_fn_cdc_support_key" {
  name         = "io-fn-cdc-support-KEY-APIM"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}
