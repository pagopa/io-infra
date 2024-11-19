########
# APIM #
########

# APIM in WEU
data "azurerm_api_management" "apim_v2_api" {
  name                = local.apim_v2_name
  resource_group_name = local.apim_resource_group_name
}

# APIM in ITN
data "azurerm_api_management" "apim_itn_api" {
  name                = local.apim_itn_name
  resource_group_name = local.apim_itn_resource_group_name
}

# For named value io_fn3_services_key_v2
data "azurerm_key_vault" "key_vault_common" {
  name                = format("%s-ioweb-kv", local.product)
  resource_group_name = format("%s-ioweb-sec-rg", local.product)
}

data "azurerm_key_vault_secret" "io_fn3_services_key_secret" {
  name         = "ioweb-profile-api-key-apim"
  key_vault_id = data.azurerm_key_vault.key_vault_common.id
}