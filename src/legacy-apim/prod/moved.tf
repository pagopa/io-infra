moved {
  from = module.api_itn_services.azurerm_api_management_api.this
  to   = azurerm_api_management_api.api_itn_services
}

moved {
  from = module.apim_itn_product_services.azurerm_api_management_product.this
  to   = azurerm_api_management_product.apim_itn_product_services
}

moved {
  from = module.api_itn_services.azurerm_api_management_api_policy.this[0]
  to   = azurerm_api_management_api_policy.api_itn_services
}

moved {
  from = module.api_itn_services.azurerm_api_management_product_api.this["io-services-api"]
  to   = azurerm_api_management_product_api.apim_itn_product_services
}

moved {
  from = module.apim_itn_product_services.azurerm_api_management_product_policy.this[0]
  to   = azurerm_api_management_product_policy.apim_itn_product_services
}
