env_short = "d"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# dns
external_domain = "pagopa.it"
dns_zone_io     = "dev.io"

lock_enable              = true
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

common_rg = "io-p-rg-common"

## Network
vnet_name = "io-p-vnet-common"

cidr_subnet_eventhub = ["10.1.xxx.xxx/xx"]
##

## Monitor
log_analytics_workspace_name    = "io-p-law-common"
application_insights_name       = "io-p-ai-common"
monitor_action_group_email_name = "EMAIL PAGOPA-ALERTS"
monitor_action_group_slack_name = "SLACK PAGOPA_STATUS"
##

## Event hub
ehns_sku_name                 = "Standard"
ehns_capacity                 = 5
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5
ehns_zone_redundant           = true
ehns_alerts_enabled           = true

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
    name              = "io-cosmosdb-services"
    partitions        = 5
    message_retention = 7
    keys = [
      {
        name   = "io-fn-elt"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  }
]
##
