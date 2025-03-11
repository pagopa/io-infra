prefix          = "io"
env_short       = "p"
env             = "prod"
domain          = "messages"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod01"

tags = {
  CreatedBy      = "Terraform"
  Environment    = "Prod"
  BusinessUnit   = "App IO"
  Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/messages-app"
  ManagementTeam = "IO Comunicazione"
  CostCenter     = "TS000 - Tecnologia e Servizi"
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

tls_cert_check_enabled = true

#################################
# CIDRS
#################################
cidr_subnet_push_notif = ["10.0.141.0/26"]

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
    name              = "messages"
    partitions        = 5
    message_retention = 7
    consumers         = []
    keys = [
      {
        name   = "io-payment-updater"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "io-fn-messages-cqrs"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "io-p-reminder"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "message-status"
    partitions        = 5
    message_retention = 7
    consumers         = []
    keys = [
      {
        name   = "io-p-reminder"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "io-fn-messages-cqrs"
        listen = false
        send   = true
        manage = false
      }
    ]
  },
  {
    name              = "message-reminder-send"
    partitions        = 5
    message_retention = 7
    consumers         = []
    keys = [
      {
        name   = "io-p-reminder"
        listen = true
        send   = true
        manage = false
      }
    ]
  },
]

## Notification Hub

nh_resource_group_name = "io-p-rg-common"
nh_name_prefix         = "io-p-ntf"
nh_namespace_prefix    = "io-p-ntfns"
nh_partition_count     = 4

###############################
# Push Notification
###############################
push_notif_enabled = true
# App Messages
push_notif_function_always_on = true

push_notif_function_kind              = "Linux"
push_notif_function_sku_tier          = "PremiumV3"
push_notif_function_sku_size          = "P1v3"
push_notif_function_autoscale_minimum = 1
push_notif_function_autoscale_maximum = 15
push_notif_function_autoscale_default = 10

###############################
# Messages functions
###############################
app_messages_count         = 2
cidr_subnet_appmessages    = ["10.0.127.0/24", "10.0.128.0/24"]
cidr_subnet_appmessages_xl = ["10.0.210.0/24", "10.0.211.0/24"]

###############################
# Messages cqrs functions
###############################
cidr_subnet_fnmessagescqrs = ["10.0.129.0/24"]

###############################
# Service messages functions
###############################
cidr_subnet_fnservicemessages     = ["10.0.148.0/26"]
function_service_messages_enabled = true
