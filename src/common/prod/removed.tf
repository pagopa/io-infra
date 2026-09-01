# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = module.function_app_elt.azurerm_key_vault_access_policy.function_elt_itn_kv_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_key_vault_access_policy.function_elt_itn_slot_staging_kv_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_monitor_diagnostic_setting.queue_diagnostic_setting

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_monitor_scheduled_query_rules_alert_v2.profile_deletion_failure_alert_rule

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_monitor_scheduled_query_rules_alert_v2.profiles_failure_alert_rule

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_monitor_scheduled_query_rules_alert_v2.service_preferences_failure_alert_rule

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_resource_group.itn_elt

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_storage_queue.pdnd-io-cosmosdb-profile-deletion-failure

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_storage_queue.pdnd-io-cosmosdb-profile-deletion-failure-poison

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_storage_queue.pdnd-io-cosmosdb-profiles-failure

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_storage_queue.pdnd-io-cosmosdb-profiles-failure-poison

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_storage_queue.pdnd-io-cosmosdb-service-preferences-failure

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_storage_queue.pdnd-io-cosmosdb-service-preferences-failure-poison

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_storage_queue.pdnd-io-cosmosdb-services-failure

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_storage_queue.pdnd-io-cosmosdb-services-failure-poison

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_storage_table.fneltcommands_itn

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.azurerm_storage_table.fnelterrors_itn

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_linux_function_app_slot.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_linux_function_app.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_monitor_metric_alert.function_app_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_monitor_metric_alert.storage_account_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_private_endpoint.function_sites

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_private_endpoint.st_blob

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_private_endpoint.st_file

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_private_endpoint.st_queue

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_private_endpoint.staging_function_sites

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_role_assignment.function_storage_account_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_role_assignment.function_storage_blob_data_owner

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_role_assignment.function_storage_queue_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_role_assignment.staging_function_storage_account_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_role_assignment.staging_function_storage_blob_data_owner

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_role_assignment.staging_function_storage_queue_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_service_plan.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_storage_account_network_rules.st_network_rules

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.function_elt_itn.azurerm_subnet.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.storage_account_itn_elt.azurerm_monitor_metric_alert.storage_account_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.storage_account_itn_elt.azurerm_private_endpoint.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_elt.module.storage_account_itn_elt.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}