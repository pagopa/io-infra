prefix          = "io"
env_short       = "p"
env             = "prod"
domain          = "messages"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "beta"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/tree/main/src/messages"
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

tls_cert_check_enabled = false

### Aks

ingress_load_balancer_ip = "10.10.0.254"

## Notification Hub

nh_resource_group_name = "io-p-rg-common"
nh_name_prefix         = "io-p-ntf"
nh_namespace_prefix    = "io-p-ntfns"
nh_partition_count     = 4

#################################
# CIDRS
#################################
cidr_subnet_push_notif = ["10.0.140.0/26"]

###############################
# Messages functions
###############################
app_messages_count      = 1
cidr_subnet_appmessages = ["10.0.127.0/24", "10.0.128.0/24"]

###############################
# Messages cqrs functions
###############################
cidr_subnet_fnmessagescqrs = ["10.0.129.0/24"]
