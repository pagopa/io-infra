locals {
  resource_group_name_common = "${var.project}-rg-common"

  subsmigrations = {
    db = {
      metric_alerts = {
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
