removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product.sign
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_api_gateway_apim_itn.azurerm_api_management_product_policy.sign
  lifecycle {
    destroy = false
  }
}
