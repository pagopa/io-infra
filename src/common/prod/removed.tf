# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

removed {
  from = module.storage_accounts_itn.azurerm_storage_account.iopitndataexportst01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.azurerm_storage_account.iopitnlogst01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.azurerm_storage_account.retirements_itn_01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.azurerm_storage_encryption_scope.iopitnlogst01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.azurerm_storage_management_policy.iopitnlogst01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.module.retirements_itn_01_admins.module.storage_account.azurerm_role_assignment.blob

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.module.retirements_itn_01_admins.module.storage_account.azurerm_role_assignment.table

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.azurerm_storage_account.iopitndataexportst01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.azurerm_storage_account.iopitnlogst01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.azurerm_storage_account.retirements_itn_01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.azurerm_storage_encryption_scope.iopitnlogst01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.azurerm_storage_management_policy.iopitnlogst01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.module.retirements_itn_01_admins.module.storage_account.azurerm_role_assignment.blob

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts_itn.module.retirements_itn_01_admins.module.storage_account.azurerm_role_assignment.table

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.azurerm_storage_account.app

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.azurerm_storage_account.exportdata_weu_01

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.azurerm_storage_account.logs

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.module.exportdata_weu_01_com_admins.module.storage_account.azurerm_role_assignment.blob

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.module.exportdata_weu_01_com_admins.module.storage_account.azurerm_role_assignment.queue

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.module.exportdata_weu_01_com_admins.module.storage_account.azurerm_role_assignment.table

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.module.exportdata_weu_01_com_devs.module.storage_account.azurerm_role_assignment.blob

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.module.exportdata_weu_01_com_devs.module.storage_account.azurerm_role_assignment.queue

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.module.exportdata_weu_01_com_devs.module.storage_account.azurerm_role_assignment.table

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.module.legacy_assets_cdn_storage_account.azurerm_monitor_metric_alert.storage_account_low_availability

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.module.legacy_assets_cdn_storage_account.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_accounts.module.legacy_cdn_svc_devs.module.storage_account.azurerm_role_assignment.blob

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.st_app_primary_connection_string

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.st_logs_primary_connection_string

  lifecycle {
    destroy = false
  }
}