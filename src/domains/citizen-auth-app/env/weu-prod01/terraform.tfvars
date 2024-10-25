prefix           = "io"
env_short        = "p"
env              = "prod"
domain           = "citizen-auth"
location         = "westeurope"
location_short   = "weu"
location_string  = "West Europe"
instance         = "prod01"
lollipop_enabled = true

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/tree/main/src/citizen-auth"
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

# Functions LolliPoP
cidr_subnet_fnlollipop              = ["10.0.17.0/26"]
cidr_subnet_fnlollipop_itn          = ["10.20.6.0/26"]
function_lollipop_kind              = "Linux"
function_lollipop_sku_size          = "P2mv3"
function_lollipop_autoscale_minimum = 3
function_lollipop_autoscale_maximum = 20
function_lollipop_autoscale_default = 10

# Functions Fast Login
cidr_subnet_fnfastlogin_itn          = ["10.20.18.0/26"]
function_fastlogin_kind              = "Linux"
function_fastlogin_sku_size          = "P2mv3"
function_fastlogin_autoscale_minimum = 2
function_fastlogin_autoscale_maximum = 20
function_fastlogin_autoscale_default = 10

# Functions app profile (located in Italy North)
cidr_subnet_profile_itn   = ["10.20.6.64/26", "10.20.6.128/26"]
function_profile_kind     = "Linux"
function_profile_sku_size = "P2mv3"

# Functions app profile async (located in Italy North)
cidr_subnet_profile_async_itn            = ["10.20.6.192/26"]
function_profile_async_kind              = "Linux"
function_profile_async_sku_size          = "P1v3"
function_profile_async_autoscale_minimum = 3 # 3 instance to achieve redundancy and failover
function_profile_async_autoscale_maximum = 30
function_profile_async_autoscale_default = 10

# shared plan
cidr_subnet_shared_1   = ["10.20.18.64/26"]
plan_shared_1_kind     = "Linux"
plan_shared_1_sku_tier = "PremiumV3"
plan_shared_1_sku_size = "P1v3"

# Functions public ITN
function_public_autoscale_minimum = 3
function_public_autoscale_maximum = 30
function_public_autoscale_default = 10

# Session manager
cidr_subnet_session_manager    = ["10.0.149.0/26"]
cidr_subnet_session_manager_04 = ["10.0.149.64/26"]
session_manager_autoscale_settings = {
  autoscale_minimum = 3
  autoscale_default = 3
  autoscale_maximum = 30
}

# DNS
external_domain = "pagopa.it"
dns_zone_io     = "io"
