locals {
  function_subscriptionmigrations = {

    // As we run this application under SelfCare IO logic subdomain,
    //  we share some resources
    app_context = {
      name             = "subsmigrations"
      resource_group   = data.azurerm_resource_group.selfcare_be_rg
      app_service_plan = azurerm_service_plan.selfcare_be_common
      snet             = data.azurerm_subnet.selfcare_be_common_snet
      vnet             = module.vnet_common
    }

    db = {
      name = format("%s-%s-db-postgresql", local.project, "subsmigrations")
    }

    metric_alerts = {
      db = {
        cpu = {
          aggregation = "Average"
          metric_name = "cpu_percent"
          operator    = "GreaterThan"
          threshold   = 70
          frequency   = "PT1M"
          window_size = "PT5M"
          dimension   = []
        }
        memory = {
          aggregation = "Average"
          metric_name = "memory_percent"
          operator    = "GreaterThan"
          threshold   = 75
          frequency   = "PT1M"
          window_size = "PT5M"
          dimension   = []
        }
        io = {
          aggregation = "Average"
          metric_name = "io_consumption_percent"
          operator    = "GreaterThan"
          threshold   = 55
          frequency   = "PT1M"
          window_size = "PT5M"
          dimension   = []
        }
        # https://docs.microsoft.com/it-it/azure/postgresql/concepts-limits
        # GP_Gen5_2 -| 145 / 100 * 80 = 116
        # GP_Gen5_32 -| 1495 / 100 * 80 = 1196
        max_active_connections = {
          aggregation = "Average"
          metric_name = "active_connections"
          operator    = "GreaterThan"
          threshold   = 1196
          frequency   = "PT5M"
          window_size = "PT5M"
          dimension   = []
        }
        min_active_connections = {
          aggregation = "Average"
          metric_name = "active_connections"
          operator    = "LessThanOrEqual"
          threshold   = 0
          frequency   = "PT5M"
          window_size = "PT15M"
          dimension   = []
        }
        failed_connections = {
          aggregation = "Total"
          metric_name = "connections_failed"
          operator    = "GreaterThan"
          threshold   = 10
          frequency   = "PT5M"
          window_size = "PT15M"
          dimension   = []
        }
        replica_lag = {
          aggregation = "Average"
          metric_name = "pg_replica_log_delay_in_seconds"
          operator    = "GreaterThan"
          threshold   = 60
          frequency   = "PT1M"
          window_size = "PT5M"
          dimension   = []
        }
      }
    }
  }
}

#
# DB
#

module "subscriptionmigrations_db_server" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//postgresql_server?ref=v7.61.0"

  name                = local.function_subscriptionmigrations.db.name
  location            = var.location
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name

  administrator_login          = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_username.value
  administrator_login_password = data.azurerm_key_vault_secret.subscriptionmigrations_db_server_adm_password.value

  sku_name                     = "GP_Gen5_2"
  db_version                   = 11
  geo_redundant_backup_enabled = false

  public_network_access_enabled = false
  private_endpoint = {
    enabled              = true
    virtual_network_id   = local.function_subscriptionmigrations.app_context.vnet.id
    subnet_id            = module.private_endpoints_subnet.id
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_postgres_database_azure_com.id]
  }

  alerts_enabled                = true
  monitor_metric_alert_criteria = local.function_subscriptionmigrations.metric_alerts.db
  action = [
    {
      action_group_id    = azurerm_monitor_action_group.error_action_group.id
      webhook_properties = null
    }
  ]

  lock_enable = var.lock_enable

  tags = var.tags
}

resource "azurerm_postgresql_database" "selfcare_subscriptionmigrations_db" {
  name                = "db"
  resource_group_name = local.function_subscriptionmigrations.app_context.resource_group.name
  server_name         = module.subscriptionmigrations_db_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
