resource "azurerm_api_management_named_value" "io_fn_cgn_card_url" {
  name                = "io-cgn-card-func-url"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "io-cgn-card-func-url"
  value               = "https://io-p-itn-cgn-card-func-02.azurewebsites.net"
}

resource "azurerm_api_management_named_value" "io_fn_cgn_card_key" {
  name                = "io-fn-cgn-card-key"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "io-fn-cgn-card-key"
  value               = data.azurerm_key_vault_secret.io_fn_cgn_card_key.value
  secret              = "true"
}

resource "azurerm_api_management_named_value" "cgn_external_activation_group_name" {
  name                = "cgn-external-activation-group-name"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "cgn-external-activation-group-name"
  value               = azurerm_api_management_group.cgn_external_activation_group.display_name
  secret              = "false"
}