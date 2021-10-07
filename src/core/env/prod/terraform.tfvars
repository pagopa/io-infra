env_short = "p"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# external_domain = "pagopa.it"
# dns_zone_prefix = "io"

lock_enable = true

common_rg = "io-p-rg-common"

# networking
vnet_name = "io-p-vnet-common"
# cidr_vnet         = ["10.0.0.0/16"]
cidr_subnet_eventhub = ["10.0.10.0/24"]
cidr_subnet_azdoa    = ["10.0.250.0/24"]
cidr_subnet_fnelt    = ["10.0.11.0/24"]

# azure devops
azdo_sp_tls_cert_enabled = false
enable_azdoa             = true
enable_iac_pipeline      = true
##

## Monitor
log_analytics_workspace_name = "io-p-law-common"
application_insights_name    = "io-p-ai-common"
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
    consumers         = []
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

# eventhubs = [
#   {
#     name              = "bpd-citizen-trx"
#     partitions        = 32
#     message_retention = 7
#     consumers         = ["bpd-citizen"]
#     keys = [
#       {
#         name   = "bpd-payment-instrument"
#         listen = false
#         send   = true
#         manage = false
#       },
#       {
#         name   = "bpd-citizen"
#         listen = true
#         send   = false
#         manage = false
#       }
#     ]
#   },
#   {
#     name              = "bpd-trx"
#     partitions        = 32
#     message_retention = 7
#     consumers         = ["bpd-point-processor"]
#     keys = [
#       {
#         name   = "bpd-payment-instrument"
#         listen = false
#         send   = true
#         manage = false
#       },
#       {
#         name   = "bpd-point-processor"
#         listen = true
#         send   = false
#         manage = false
#       },
#       {
#         name   = "bpd-citizen"
#         listen = false
#         send   = true
#         manage = false
#       }
#     ]
#   },
#   {
#     name              = "bpd-trx-cashback"
#     partitions        = 32
#     message_retention = 7
#     consumers         = ["bpd-winning-transaction"]
#     keys = [
#       {
#         name   = "bpd-point-processor"
#         listen = false
#         send   = true
#         manage = false
#       },
#       {
#         name   = "bpd-winning-transaction"
#         listen = true
#         send   = false
#         manage = false
#       },
#     ]
#   },
#   {
#     name              = "bpd-trx-error"
#     partitions        = 3
#     message_retention = 7
#     consumers         = ["bpd-transaction-error-manager"]
#     keys = [
#       {
#         name   = "bpd-point-processor"
#         listen = false
#         send   = true
#         manage = false
#       },
#       {
#         name   = "bpd-transaction-error-manager"
#         listen = true
#         send   = false
#         manage = false
#       },
#       {
#         name   = "bpd-payment-instrument"
#         listen = false
#         send   = true
#         manage = false
#       }
#     ]
#   },
#   {
#     name              = "bpd-winner-outcome"
#     partitions        = 32
#     message_retention = 7
#     consumers         = []
#     keys = [
#       {
#         name   = "award-winner"
#         listen = true
#         send   = true
#         manage = true
#       },
#       {
#         name   = "consap-csv-connector"
#         listen = false
#         send   = true
#         manage = false
#       },
#       {
#         name   = "award-winner-integration" //TODO Check
#         listen = true
#         send   = true
#         manage = false
#       }
#     ]
#   },
#   {
#     name              = "rtd-trx"
#     partitions        = 32
#     message_retention = 7
#     consumers         = ["bpd-payment-instrument"]
#     keys = [
#       {
#         name   = "rtd-csv-connector"
#         listen = false
#         send   = true
#         manage = false
#       },
#       {
#         name   = "bpd-payment-instrument"
#         listen = true
#         send   = false
#         manage = false
#       }
#     ]
#   },
#   {
#     name              = "rtd-log"
#     partitions        = 3
#     message_retention = 7
#     consumers         = ["elk"]
#     keys = [
#       {
#         name   = "app"
#         listen = false
#         send   = true
#         manage = false
#       },
#       {
#         name   = "elk"
#         listen = true
#         send   = false
#         manage = false
#       }
#     ]
#   },
# ]

##
