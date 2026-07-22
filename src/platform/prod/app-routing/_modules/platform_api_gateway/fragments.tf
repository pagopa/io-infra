## Note for resource import ##

# The format of the policy must be switched to 'xml' to sucessfully complete the import, 
# however this will cause, during the apply phase, a validation failure against the azure api.
# After letting terraform import and tentatively update the resource, switch back to 'rawxml'.
# More info here: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_policy_fragment#import

resource "azurerm_api_management_policy_fragment" "auth" {
  api_management_id = module.platform_api_gateway.id
  depends_on        = [azurerm_api_management_named_value.session_manager_introspection_url]
  name              = "ioapp-authenticated"
  format            = "rawxml"
  value             = file("${path.module}/fragments/auth.xml")
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
  value  = file("${path.module}/fragments/auth-cache.xml")
}
