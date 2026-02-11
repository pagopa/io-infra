resource "azurerm_api_management_named_value" "io_fn_cdc_support_url" {
  name                = "io-cdc-support-func-url"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "io-cdc-support-func-url"
  value               = "https://io-p-itn-cdc-support-func-01.azurewebsites.net"
}

resource "azurerm_api_management_named_value" "io_fn_cdc_support_key" {
  name                = "io-fn-cdcsupportfunc-key"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "io-fn-cdcsupportfunc-key"
  value               = data.azurerm_key_vault_secret.io_fn_cdc_support_key.value
  secret              = "true"
}

resource "azurerm_api_management_named_value" "cdc_read_group_name" {
  name                = "cdc-support-read-group-name"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "cdc-support-read-group-name"
  value               = azurerm_api_management_group.cdc_read_group.display_name
  secret              = "false"
}