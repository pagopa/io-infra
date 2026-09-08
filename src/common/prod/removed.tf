# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = module.function_app_services_02.azurerm_key_vault_access_policy.function_services_itn_kv_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_key_vault_access_policy.function_services_itn_slot_staging_kv_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_resource_group.function_services_rg

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_storage_container.processing-messages-01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_storage_management_policy.processing_messages_container_rule_01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_storage_queue.message-created-01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_storage_queue.message-created-poison-01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_storage_queue.message-processed-01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_storage_queue.message-processed-poison-01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_storage_queue.notification-created-email-01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_storage_queue.notification-created-email-poison-01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.azurerm_storage_queue.notification-created-webhook-poison-01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services_autoscale.azurerm_monitor_autoscale_setting.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services_role_assignments.module.key_vault.azurerm_role_assignment.secrets

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services_staging_slot_role_assignments.module.key_vault.azurerm_role_assignment.secrets

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_linux_function_app_slot.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_linux_function_app.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_monitor_metric_alert.function_app_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_monitor_metric_alert.storage_account_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_private_endpoint.function_sites

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_private_endpoint.st_blob

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_private_endpoint.st_file

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_private_endpoint.st_queue

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_private_endpoint.staging_function_sites

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_role_assignment.function_storage_account_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_role_assignment.function_storage_blob_data_owner

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_role_assignment.function_storage_queue_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_role_assignment.staging_function_storage_account_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_role_assignment.staging_function_storage_blob_data_owner

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_role_assignment.staging_function_storage_queue_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_service_plan.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_storage_account_network_rules.st_network_rules

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.function_services.azurerm_subnet.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.services_storage_account_01.azurerm_monitor_metric_alert.storage_account_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.services_storage_account_01.azurerm_private_endpoint.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_services_02.module.services_storage_account_01.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.containers_services.module.db_subscription_cidrs_container.azurerm_cosmosdb_sql_container.this

  lifecycle {
    destroy = false
  }
}