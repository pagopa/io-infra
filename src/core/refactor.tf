removed {
    from = module.app_gw
    lifecycle {
        destroy = false
    }
}

removed {
    from = azurerm_key_vault_access_policy.app_gateway_policy
    lifecycle {
        destroy = false
    }
}

removed {
    from = azurerm_key_vault_access_policy.app_gateway_policy_common
    lifecycle {
        destroy = false
    }
}

removed {
    from = azurerm_key_vault_access_policy.app_gateway_policy_ioweb
    lifecycle {
        destroy = false
    }
}

removed {
    from = azurerm_key_vault_access_policy.app_gw_uai_kvreader_common
    lifecycle {
        destroy = false
    }
}

removed {
    from = azurerm_public_ip.appgateway_public_ip
    lifecycle {
        destroy = false
    }
}

removed {
    from = azurerm_user_assigned_identity.appgateway
    lifecycle {
        destroy = false
    }
}

removed {
    from = azurerm_web_application_firewall_policy.api_app
    lifecycle {
        destroy = false
    }
}

removed {
    from = azurerm_web_application_firewall_policy.api_app
    lifecycle {
        destroy = false
    }
}

removed {
    from = module.appgateway_snet
    lifecycle {
        destroy = false
    }
}