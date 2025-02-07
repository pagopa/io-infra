resource "azurerm_api_management_named_value" "cgnonboardingportal_os_url_value_v2" {
  name                = "cgnonboardingportal-os-url"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "cgnonboardingportal-os-url"
  value               = "https://io-p-itn-cgn-search-func-02.azurewebsites.net"
}

resource "azurerm_api_management_named_value" "cgnonboardingportal_os_key_v2" {
  name                = "cgnonboardingportal-os-key"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "cgnonboardingportal-os-key"
  value               = data.azurerm_key_vault_secret.cgnonboardingportal_os_key.value
  secret              = true
}

resource "azurerm_api_management_named_value" "cgnonboardingportal_os_header_name_v2" {
  name                = "cgnonboardingportal-os-header-name"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "cgnonboardingportal-os-header-name"
  value               = data.azurerm_key_vault_secret.cgnonboardingportal_os_header_name.value
  secret              = true
}