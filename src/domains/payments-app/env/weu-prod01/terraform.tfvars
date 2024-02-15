prefix          = "io"
env_short       = "p"
env             = "prod"
domain          = "payments"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod01"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/tree/main/src/payments"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"
application_insights_name                   = "io-p-ai-common"

### External tools

# chart releases: https://github.com/stakater/Reloader/releases
# image tags: https://hub.docker.com/r/stakater/reloader/tags
reloader_helm = {
  chart_version = "v1.0.41"
  image_name    = "stakater/reloader"
  image_tag     = "v1.0.41@sha256:eb7e816f4c38d9c9c25fd8743919075d8ea699d8593f261c7c2e0b52080c6c47"
}
# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

### Aks

ingress_load_balancer_ip = "10.11.0.254"

## Event hub
ehns_enabled                  = true
ehns_sku_name                 = "Standard"
ehns_capacity                 = 5
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5
ehns_zone_redundant           = true
ehns_alerts_enabled           = true

ehns_ip_rules              = []
ehns_virtual_network_rules = []

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

eventhubs = [
  {
    name              = "payment-updates"
    partitions        = 5
    message_retention = 7
    consumers         = []
    keys = [
      {
        name   = "io-fn-messages-cqrs"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "io-p-reminder"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "io-payment-updater"
        listen = false
        send   = true
        manage = false
      }
    ]
  }
]
