resource "azurerm_api_management_named_value" "io_fn_cgnmerchant_url_v2" {
  name                = "io-fn-cgnmerchant-url"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "io-fn-cgnmerchant-url"
  value               = "https://${var.function_cgn_merchant_hostname}"
}

resource "azurerm_api_management_named_value" "io_fn_cgnmerchant_key_v2" {
  name                = "io-fn-cgnmerchant-key"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "io-fn-cgnmerchant-key"
  value               = data.azurerm_key_vault_secret.io_fn_cgnmerchant_key_secret_v2.value
  secret              = "true"
}
