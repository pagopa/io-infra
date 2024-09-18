removed {
  from = module.storage_api_replica.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_api_replica.azurerm_security_center_storage_defender.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_api_replica.azurerm_monitor_metric_alert.storage_account_low_availability

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_api_object_replication_to_replica.azurerm_storage_object_replication.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_api.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_api.azurerm_security_center_storage_defender.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.storage_api.azurerm_monitor_metric_alert.storage_account_low_availability

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_table.storage_api_validationtokens

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_table.storage_api_subscriptionsfeedbyday

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_table.storage_api_faileduserdataprocessing

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_queue.storage_account_apievents_events_queue

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_container.storage_api_message_content

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_storage_container.storage_api_cached

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_monitor_metric_alert.iopstapi_throttling_low_availability

  lifecycle {
    destroy = false
  }
}
