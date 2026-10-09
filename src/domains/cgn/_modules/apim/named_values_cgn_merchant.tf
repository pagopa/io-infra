resource "azurerm_api_management_named_value" "io_fn_cgnmerchant_url_v2" {
  name                = "io-fn-cgnmerchant-url"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "io-fn-cgnmerchant-url"
  value               = "https://io-p-itn-cgn-merchant-func-02.azurewebsites.net"
}

resource "azurerm_api_management_named_value" "io_fn_cgnmerchant_key_v2" {
  name                = "io-fn-cgnmerchant-key"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "io-fn-cgnmerchant-key"

  value_from_key_vault {
    secret_id = format("%s%s/%s", data.azurerm_key_vault.key_vault_common.vault_uri, "secrets", "io-fn-cgnmerchant-KEY-APIM")
  }

  secret              = "true"
}