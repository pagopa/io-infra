removed {
  from = module.apim_v2_product_admin.azurerm_api_management_product_policy.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_v2_product_admin.azurerm_api_management_product.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.api_v2_admin.azurerm_api_management_product_api.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_named_value.io_fn3_admin_url_v2
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.api_v2_admin.azurerm_api_management_api_policy.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.api_v2_admin.azurerm_api_management_api.this
  lifecycle {
    destroy = false
  }
}


removed {
  from = azurerm_api_management_named_value.io_fn3_admin_key_v2
  lifecycle {
    destroy = false
  }
}

