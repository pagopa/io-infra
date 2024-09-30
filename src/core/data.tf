data "azurerm_api_management" "apim" {
  name                = "io-p-apim-v2-api"
  resource_group_name = "io-p-rg-internal"
}

data "azurerm_key_vault" "key_vault_common" {
  name                = format("%s-kv-common", local.project)
  resource_group_name = data.azurerm_resource_group.rg_common.name
}

data "azurerm_resource_group" "rg_common" {
  name = "io-p-rg-common"
}
