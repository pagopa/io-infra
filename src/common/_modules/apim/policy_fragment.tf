resource "azurerm_api_management_policy_fragment" "auth" {
  api_management_id = module.apim_v2.id
  name              = "ioapp-authenticated"
  format            = "xml"
  value             = file("../_modules/apim/api/fragment/auth.xml")
}
