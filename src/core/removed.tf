removed {
  from = azurerm_api_management_named_value.io_fn3_public_key_v2

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_named_value.io_fn3_public_url_v2

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.api_v2_public.azurerm_api_management_api.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.api_v2_public.azurerm_api_management_api_policy.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.api_v2_public.azurerm_api_management_product_api.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_v2_product_public.azurerm_api_management_product.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_v2_product_public.azurerm_api_management_product_policy.this

  lifecycle {
    destroy = false
  }
}
