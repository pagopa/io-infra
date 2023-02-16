resource "azurerm_api_management_group" "apilollipopassertionread" {
  name                = "apilollipopassertionread"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  display_name        = "ApiLollipopAssertionRead"
  description         = "A group that enables LC to retrieve user's assertion on a Lollipop flow"
}

module "apim_product_lollipop" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_product?ref=v4.1.5"

  product_id   = "io-lollipop-api"
  display_name = "IO LOLLIPOP API"
  description  = "Product for IO Lollipop"

  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/io_lollipop/_base_policy.xml")
}

####################################################################################
# PagoPA General Lollipop User
####################################################################################
resource "azurerm_api_management_user" "pagopa_user" {
  user_id             = "iolollipoppagopauser"
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  first_name          = "PagoPA"
  last_name           = "PagoPA"
  email               = "io-lollipop-pagopa@pagopa.it"
  state               = "active"
}

resource "azurerm_api_management_group_user" "pagopa_group" {
  user_id             = azurerm_api_management_user.pagopa_user.user_id
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  group_name          = azurerm_api_management_group.apilollipopassertionread.name
}

resource "azurerm_api_management_subscription" "pagopa" {
  user_id             = azurerm_api_management_user.reminder_user.id
  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name
  product_id          = module.apim_product_lollipop.id
  display_name        = "Lollipop API"
  state               = "active"
}
####################################################################################