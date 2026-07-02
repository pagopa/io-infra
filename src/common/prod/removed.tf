# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = module.app_backend_weu.azurerm_application_insights_standard_web_test.web_tests

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_key_vault_access_policy.app_backend_kv_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_key_vault_access_policy.appservice_app_backend_slot_staging_kv_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_key_vault_secret.appbackend_THIRD_PARTY_CONFIG_LIST

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_key_vault_secret.appbackend-NORIFICATIONS-STORAGE

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_key_vault_secret.appbackend-REDIS-PASSWORD

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_key_vault_secret.appbackend-SPID-LOG-STORAGE

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_key_vault_secret.appbackend-USERS-LOGIN-STORAGE

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_monitor_metric_alert.metric_alerts

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_monitor_metric_alert.too_many_http_5xx

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_private_endpoint.app_backend

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_private_endpoint.app_backend_staging

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_role_assignment.appbackend_adgroup_auth_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_role_assignment.appbackend_adgroup_bonus_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_role_assignment.appbackend_adgroup_com_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_role_assignment.appbackend_adgroup_svc_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_role_assignment.appbackend_adgroup_wallet_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_role_assignment.appbackend_staging_adgroup_auth_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_role_assignment.appbackend_staging_adgroup_bonus_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_role_assignment.appbackend_staging_adgroup_com_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_role_assignment.appbackend_staging_adgroup_svc_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_role_assignment.appbackend_staging_adgroup_wallet_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_subnet_nat_gateway_association.snet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.azurerm_subnet.snet

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.module.appservice_app_backend_slot_staging.azurerm_app_service_slot_virtual_network_swift_connection.app_service_virtual_network_swift_connection

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.module.appservice_app_backend_slot_staging.azurerm_linux_web_app_slot.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.module.appservice_app_backend.azurerm_app_service_virtual_network_swift_connection.app_service_virtual_network_swift_connection

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.module.appservice_app_backend.azurerm_linux_web_app.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.app_backend_weu.module.appservice_app_backend.azurerm_service_plan.this

  lifecycle {
    destroy = false
  }
}