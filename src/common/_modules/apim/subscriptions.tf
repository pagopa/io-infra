
# resource "azurerm_api_management_subscription" "pn_lc_subscription_v2" {
#   user_id             = azurerm_api_management_user.pn_user_v2.id
#   api_management_name = module.apim_v2.name
#   resource_group_name = module.apim_v2.resource_group_name
#   product_id          = data.azurerm_api_management_product.apim_v2_product_lollipop.id
#   display_name        = "PN LC"
#   state               = "active"
#   allow_tracing       = false
# }
