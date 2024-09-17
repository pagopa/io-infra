
resource "azurerm_api_management_user" "pn_user_v2" {
  user_id             = "pnapimuser"
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  first_name          = "PNAPIMuser"
  last_name           = "PNAPIMuser"
  email               = "pn-apim-user@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "pn_user_group_v2" {
  user_id             = azurerm_api_management_user.pn_user_v2.user_id
  api_management_name = module.apim_v2.name
  resource_group_name = module.apim_v2.resource_group_name
  group_name          = data.azurerm_api_management_group.api_v2_lollipop_assertion_read.name
}
