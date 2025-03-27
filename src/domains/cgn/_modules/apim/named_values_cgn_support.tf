resource "azurerm_api_management_named_value" "io_fn_cgn_support_url" {
  name                = "io-cgn-support-func-url"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "io-cgn-support-func-url"
  value               = "https://io-p-itn-cgn-support-func-01.azurewebsites.net"
}

resource "azurerm_api_management_named_value" "io_fn_cgn_support_key" {
  name                = "io-fn-cgnsupportfunc-key"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "io-fn-cgnsupportfunc-key"
  value               = data.azurerm_key_vault_secret.io_fn_cgn_support_key.value
  secret              = "true"
}