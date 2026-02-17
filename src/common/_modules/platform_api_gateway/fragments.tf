resource "azurerm_api_management_policy_fragment" "auth" {
  api_management_id = module.platform_api_gateway.id
  depends_on        = [azurerm_api_management_named_value.session_manager_introspection_url]
  name              = "ioapp-authenticated"
  format            = "rawxml"
  value             = file("../_modules/platform_api_gateway/fragments/auth.xml")
}

resource "azurerm_api_management_policy_fragment" "auth_cache" {
  api_management_id = module.platform_api_gateway.id
  depends_on = [
    azurerm_api_management_named_value.session_manager_introspection_url,
    azurerm_api_management_named_value.session_token_cache_prefix,
    azurerm_api_management_named_value.platform_api_gateway_hostname_internal
  ]
  name   = "ioapp-authenticated-cache"
  format = "rawxml"
  value  = file("../_modules/platform_api_gateway/fragments/auth-cache.xml")
}
