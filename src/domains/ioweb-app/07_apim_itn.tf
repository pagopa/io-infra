removed {
  from = module.apim_itn_bff_api.azurerm_api_management_api.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn_bff_api.azurerm_api_management_api_policy.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_itn_bff_api.azurerm_api_management_product_api.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_api_operation_policy.unlock_user_session_policy_itn
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_named_value.io_fn3_services_key_itn
  lifecycle {
    destroy = false
  }
}