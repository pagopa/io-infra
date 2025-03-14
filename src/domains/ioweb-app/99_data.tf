########
# APIM #
########

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

###########################
# Function io-web-profile #
###########################

data "azurerm_linux_function_app" "function_web_profile" {
  name                = format("%s-webprof-func-01", local.short_project_itn)
  resource_group_name = format("%s-webprof-rg-01", local.short_project_itn)
}
