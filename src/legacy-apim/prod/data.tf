# APIM in WEU
data "azurerm_api_management" "apim" {
  name                = local.apim_v2_name
  resource_group_name = local.apim_resource_group_name
}

# APIM in ITN
data "azurerm_api_management" "apim_itn" {
  name                = local.apim_itn_name
  resource_group_name = local.apim_itn_resource_group_name
}

data "azurerm_key_vault" "key_vault_common" {
  name                = format("%s-kv-common", local.project)
  resource_group_name = data.azurerm_resource_group.rg_common.name
}

data "azurerm_resource_group" "rg_common" {
  name = "io-p-rg-common"
}
