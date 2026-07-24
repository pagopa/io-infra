# This file will contain all the removed without destroy code blocks generated and used during the common domain split into multiple subdomains / platform
# https://pagopa.atlassian.net/browse/IOPLT-1626

# PLATFORM SERVICE BUS

removed {
  from = module.platform_service_bus_namespace_itn.module.platform_service_bus_namespace.azurerm_monitor_autoscale_setting.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_service_bus_namespace_itn.module.platform_service_bus_namespace.azurerm_private_endpoint.service_bus_pep

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.platform_service_bus_namespace_itn.module.platform_service_bus_namespace.azurerm_servicebus_namespace.this

  lifecycle {
    destroy = false
  }
}

# EVENT HUB

removed {
  from = module.event_hubs_weu.azurerm_key_vault_secret.event_hub_keys

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.event_hubs_weu.azurerm_resource_group.event_rg

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.event_hubs_weu.module.event_hub.azurerm_eventhub_authorization_rule.events

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.event_hubs_weu.module.event_hub.azurerm_eventhub_consumer_group.events

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.event_hubs_weu.module.event_hub.azurerm_eventhub_namespace.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.event_hubs_weu.module.event_hub.azurerm_eventhub.events

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.event_hubs_weu.module.event_hub.azurerm_monitor_metric_alert.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.event_hubs_weu.module.eventhub_snet.azurerm_subnet.this

  lifecycle {
    destroy = false
  }
}

# REDIS

removed {
  from = module.redis_weu.azurerm_redis_cache.common

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.redis_weu.azurerm_subnet.redis

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.redis_weu.module.redis_common_backup_zrs.azurerm_monitor_metric_alert.storage_account_low_availability

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.redis_weu.module.redis_common_backup_zrs.azurerm_security_center_storage_defender.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.redis_weu.module.redis_common_backup_zrs.azurerm_storage_account.this

  lifecycle {
    destroy = false
  }
}

# COSMOS

removed {
  from = module.cosmos_api_weu.azurerm_cosmosdb_account.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_cosmosdb_sql_container.these

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_cosmosdb_sql_database.db

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_monitor_metric_alert.throttling_alert

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_private_endpoint.sql

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_private_endpoint.sql_itn

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_auth_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_auth_devs

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_com_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_com_devs

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_identities

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_svc_admins

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.azurerm_role_assignment.cosno_api_svc_devs

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.module.cosno_api_auth_admins.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.module.cosno_api_auth_devs.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.module.cosno_api_com_admins.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.module.cosno_api_com_devs.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.module.cosno_api_svc_admins.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.cosmos_api_weu.module.cosno_api_svc_devs.module.cosmos.azurerm_cosmosdb_sql_role_assignment.this

  lifecycle {
    destroy = false
  }
}