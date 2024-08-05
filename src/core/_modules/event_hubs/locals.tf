locals {
  ehns_metric_alerts = {
    no_trx = {
      aggregation = "Total"
      metric_name = "IncomingMessages"
      description = "No transactions received from acquirer in the last 24h"
      operator    = "LessThanOrEqual"
      threshold   = 1000
      frequency   = "PT1H"
      window_size = "P1D"
      dimension = [
        {
          name     = "EntityName"
          operator = "Include"
          values   = ["rtd-trx"]
        }
      ],
    },
    active_connections = {
      aggregation = "Average"
      metric_name = "ActiveConnections"
      description = null
      operator    = "LessThanOrEqual"
      threshold   = 0
      frequency   = "PT5M"
      window_size = "PT15M"
      dimension   = [],
    },
    error_trx = {
      aggregation = "Total"
      metric_name = "IncomingMessages"
      description = "Transactions rejected from one acquirer file received. trx write on eventhub. check immediately"
      operator    = "GreaterThan"
      threshold   = 0
      frequency   = "PT5M"
      window_size = "PT30M"
      dimension = [
        {
          name     = "EntityName"
          operator = "Include"
          values = ["bpd-trx-error",
          "rtd-trx-error"]
        }
      ],
    },
  }

  nonstandard = {
    weu = {
      evh-rg   = "${var.project}-evt-rg"
      evh-snet = "${var.project}-eventhub-snet"
      evh-ns   = "${var.project}-evh-ns"
    }
  }
}
