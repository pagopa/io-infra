env_short = "p"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# dns
external_domain      = "pagopa.it"
dns_zone_io          = "io"
dns_zone_io_selfcare = "io.selfcare"

lock_enable = true

common_rg = "io-p-rg-common"

# networking
vnet_name = "io-p-vnet-common"
# cidr_vnet         = ["10.0.0.0/16"]
# check free subnet on azure portal io-p-vnet-common -> subnets
cidr_subnet_eventhub           = ["10.0.10.0/24"]
cidr_subnet_fnelt              = ["10.0.11.0/24"]
cidr_subnet_fnpblevtdispatcher = ["10.0.12.0/24"]
cidr_subnet_appgateway         = ["10.0.13.0/24"]
cidr_subnet_redis_apim         = ["10.0.14.0/24"]
cidr_subnet_apim               = ["10.0.101.0/24"]
cidr_subnet_appmessages        = ["10.0.127.0/24", "10.0.128.0/24"]
cidr_subnet_fnmessagescqrs     = ["10.0.129.0/24"]
cidr_subnet_vpn                = ["10.0.133.0/24"]
cidr_subnet_selfcare_be        = ["10.0.137.0/24"]
cidr_subnet_appbackendl1       = ["10.0.152.0/24"]
cidr_subnet_appbackendl2       = ["10.0.153.0/24"]
cidr_subnet_appbackendli       = ["10.0.154.0/24"]
cidr_subnet_azdoa              = ["10.0.250.0/24"]
cidr_subnet_dnsforwarder       = ["10.0.252.8/29"]

app_gateway_api_certificate_name                                  = "api-io-pagopa-it"
app_gateway_api_mtls_certificate_name                             = "api-mtls-io-pagopa-it"
app_gateway_api_app_certificate_name                              = "api-app-io-pagopa-it"
app_gateway_api_io_italia_it_certificate_name                     = "api-io-italia-it"
app_gateway_app_backend_io_italia_it_certificate_name             = "app-backend-io-italia-it"
app_gateway_developerportal_backend_io_italia_it_certificate_name = "developerportal-backend-io-italia-it"
app_gateway_api_io_selfcare_pagopa_it_certificate_name            = "api-io-selfcare-pagopa-it"
app_gateway_min_capacity                                          = 4
app_gateway_max_capacity                                          = 50
app_gateway_alerts_enabled                                        = true

# redis
redis_apim_sku_name = "Premium"
redis_apim_family   = "P"

# apim
apim_publisher_name = "IO"
apim_sku            = "Premium_1"

# azure devops
azdo_sp_tls_cert_enabled = true
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

ehns_ip_rules = [
  {
    ip_mask = "18.192.147.151", # PDND
    action  = "Allow"
  }
]

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

# App Messages
app_messages_function_always_on = true

app_messages_function_kind              = "Linux"
app_messages_function_sku_tier          = "PremiumV3"
app_messages_function_sku_size          = "P1v3"
app_messages_function_autoscale_minimum = 1
app_messages_function_autoscale_maximum = 30
app_messages_function_autoscale_default = 1

app_backend_autoscale_default = 10
app_backend_autoscale_minimum = 1
app_backend_autoscale_maximum = 30

# Function Messages CQRS
function_messages_cqrs_always_on = true

function_messages_cqrs_kind              = "Linux"
function_messages_cqrs_sku_tier          = "PremiumV3"
function_messages_cqrs_sku_size          = "P1v3"
function_messages_cqrs_autoscale_minimum = 1
function_messages_cqrs_autoscale_maximum = 30
function_messages_cqrs_autoscale_default = 10


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
  },
  {
    name              = "io-cosmosdb-profiles"
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
  },
  {
    name              = "import-command"
    partitions        = 2
    message_retention = 7
    consumers         = []
    keys = [
      {
        name   = "ops"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "io-fn-elt"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "io-cosmosdb-message-status"
    partitions        = 32
    message_retention = 7
    consumers         = ["io-messages"]
    keys = [
      {
        name   = "io-cdc"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "io-messages"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "pdnd-io-cosmosdb-messages"
    partitions        = 30
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
  },
  {
    name              = "pdnd-io-cosmosdb-message-status"
    partitions        = 30
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
  },
  {
    name              = "pdnd-io-cosmosdb-notification-status"
    partitions        = 30
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
  },
  {
    name              = "io-cosmosdb-message-status-for-view"
    partitions        = 32
    message_retention = 7
    consumers         = ["io-messages"]
    keys = [
      {
        name   = "io-cdc"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "io-messages"
        listen = true
        send   = false
        manage = false
      }
    ]
  }
]
