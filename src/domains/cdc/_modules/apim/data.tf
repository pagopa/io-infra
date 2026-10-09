data "azurerm_api_management" "apim" {
  name                = var.apim.name
  resource_group_name = var.apim.resource_group_name
}

data "azurerm_key_vault" "key_vault_common" {
  name                = "${var.project}-kv-common"
  resource_group_name = local.resource_group_name_common
}
