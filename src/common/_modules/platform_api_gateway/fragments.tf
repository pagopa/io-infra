resource "azurerm_api_management_policy_fragment" "auth" {
  api_management_id = module.platform_api_gateway.id
  depends_on        = [azurerm_api_management_named_value.session_manager_introspection_url]
  name              = "ioapp-authenticated"
  format            = "xml"
  value             = file("../_modules/platform_api_gateway/fragment/auth.xml")
}
