prefix            = "io"
env_short         = "p"
env               = "prod"
domain            = "citizen-auth"
location          = "westeurope"
location_short    = "weu"
location_string   = "West Europe"
instance          = "prod01"
lollipop_enabled  = true
fastlogin_enabled = true
fims_enabled      = true

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
  chart_version = "v0.0.118"
  image_name    = "stakater/reloader"
  image_tag     = "v0.0.118@sha256:2d423cab8d0e83d1428ebc70c5c5cafc44bd92a597bff94007f93cddaa607b02"
}
# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

### Aks

ingress_load_balancer_ip = "10.11.100.250"

# Functions LolliPoP
cidr_subnet_fnlollipop              = ["10.0.17.0/26"]
function_lollipop_kind              = "Linux"
function_lollipop_sku_tier          = "PremiumV3"
function_lollipop_sku_size          = "P1v3"
function_lollipop_autoscale_minimum = 1
function_lollipop_autoscale_maximum = 3
function_lollipop_autoscale_default = 1

# Functions Fast Login
cidr_subnet_fnfastlogin              = ["10.0.17.128/26"]
function_fastlogin_kind              = "Linux"
function_fastlogin_sku_size          = "P1v3"
function_fastlogin_autoscale_minimum = 2
function_fastlogin_autoscale_maximum = 20
function_fastlogin_autoscale_default = 10

# FIMS App Service
cidr_subnet_fims       = ["10.0.18.0/26"]
cidr_subnet_fims_plus  = ["10.0.18.64/26"]
fims_plan_sku_tier     = "PremiumV3"
fims_plan_sku_size     = "P1v3"
fims_autoscale_minimum = 1
fims_autoscale_maximum = 3
fims_autoscale_default = 1
