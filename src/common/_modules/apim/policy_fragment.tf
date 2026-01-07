resource "azurerm_api_management_policy_fragment" "auth" {
  api_management_id = module.apim_v2.id
  depends_on        = [azurerm_api_management_named_value.session_manager_baseurl, azurerm_api_management_named_value.session_manager_introspection_url]
  name              = "ioapp-authenticated"
  format            = "xml"
  value             = file("../_modules/apim/api/fragment/auth.xml")
}
