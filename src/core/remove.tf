removed {
  from = module.apim_v2_snet

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_network_security_group.nsg_apim

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_subnet_network_security_group_association.snet_nsg

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_public_ip.public_ip_apim

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.apim_v2

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.apim_v2_kv_policy

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_access_policy.v2_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_user.pn_user_v2

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_group_user.pn_user_group_v2

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_api_management_subscription.pn_lc_subscription_v2

  lifecycle {
    destroy = false
  }
}
