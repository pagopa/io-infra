# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = module.function_app_admin.azurerm_key_vault_access_policy.function_admin_itn_kv_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.azurerm_key_vault_access_policy.function_admin_itn_slot_staging_kv_common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.azurerm_monitor_autoscale_setting.function_admin

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.azurerm_monitor_scheduled_query_rules_alert_v2.alert_failed_delete_procedure

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.azurerm_monitor_scheduled_query_rules_alert_v2.alert_failed_download_procedure

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.azurerm_resource_group.function_admin_itn_rg

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.azurerm_storage_management_policy.user_data_download_container_rule

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_linux_function_app_slot.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_linux_function_app.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_monitor_metric_alert.function_app_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_monitor_metric_alert.storage_account_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_private_endpoint.function_sites

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_private_endpoint.st_blob

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_private_endpoint.st_file

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_private_endpoint.st_queue

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_private_endpoint.staging_function_sites

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_private_endpoint.std_blob

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_private_endpoint.std_file

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_private_endpoint.std_queue

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_private_endpoint.std_table

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.durable_function_storage_blob_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.durable_function_storage_queue_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.durable_function_storage_table_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.function_storage_account_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.function_storage_blob_data_owner

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.function_storage_queue_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.staging_durable_function_storage_blob_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.staging_durable_function_storage_queue_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.staging_durable_function_storage_table_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.staging_function_storage_account_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.staging_function_storage_blob_data_owner

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_role_assignment.staging_function_storage_queue_data_contributor

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_service_plan.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_storage_account_network_rules.st_network_rules

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_storage_account_network_rules.std_network_rules

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_storage_account.durable_function

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_itn.azurerm_subnet.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_storage_account.azurerm_monitor_metric_alert.storage_account_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_storage_account.azurerm_private_endpoint.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.function_admin_storage_account.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_key_vault_key.key

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_monitor_diagnostic_setting.blob_service

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_monitor_diagnostic_setting.queue_service

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_monitor_diagnostic_setting.storage_account

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_monitor_metric_alert.storage_account_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_private_endpoint.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_role_assignment.keys

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_storage_account_customer_managed_key.kv

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_storage_account.secondary_replica

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_storage_container.replica

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_storage_container.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_storage_management_policy.lifecycle_audit

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_storage_management_policy.secondary_lifecycle_audit

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_backups_storage_account.azurerm_storage_object_replication.geo_replication_policy

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_download_storage_account.azurerm_monitor_metric_alert.storage_account_health_check

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_download_storage_account.azurerm_security_center_storage_defender.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_download_storage_account.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.function_app_admin.module.user_data_download_storage_account.azurerm_storage_container.this

  lifecycle {
    destroy = false
  }
}