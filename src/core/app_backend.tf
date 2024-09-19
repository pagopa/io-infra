removed {
  from = azurerm_key_vault_secret.appbackend-NORIFICATIONS-STORAGE
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.appbackend-PUSH-NOTIFICATIONS-STORAGE
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.appbackend-REDIS-PASSWORD
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.appbackend-SPID-LOG-STORAGE
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.appbackend-USERS-LOGIN-STORAGE
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.appbackend_LOLLIPOP_ASSERTIONS_STORAGE
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.appbackend_THIRD_PARTY_CONFIG_LIST
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_autoscale_setting.appservice_app_backendli
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_metric_alert.too_many_http_5xx
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_resource_group.rg_linux
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_subnet_nat_gateway_association.app_backendl1_snet
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_subnet_nat_gateway_association.app_backendl2_snet
  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_subnet_nat_gateway_association.app_backendli_snet
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_web_test_api
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backendl1_snet.azurerm_subnet.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backendl2_snet.azurerm_subnet.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backendli_snet.azurerm_subnet.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendl1.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendl1.azurerm_linux_web_app.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendl1.azurerm_service_plan.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendl1_slot_staging.azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendl1_slot_staging.azurerm_linux_web_app_slot.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendl2.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendl2.azurerm_linux_web_app.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendl2.azurerm_service_plan.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendl2_slot_staging.azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendl2_slot_staging.azurerm_linux_web_app_slot.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendli.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendli.azurerm_linux_web_app.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendli.azurerm_service_plan.this
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendli_slot_staging.azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.appservice_app_backendli_slot_staging.azurerm_linux_web_app_slot.this
  lifecycle {
    destroy = false
  }
}

