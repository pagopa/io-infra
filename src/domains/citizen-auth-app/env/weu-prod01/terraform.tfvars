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
  CreatedBy      = "Terraform"
  Environment    = "Prod"
  BusinessUnit   = "App IO"
  ManagementTeam = "IO Autenticazione"
  Source         = "https://github.com/pagopa/io-infra/tree/main/src/citizen-auth"
  CostCenter     = "TS000 - Tecnologia e Servizi"
}

### External resources

monitor_resource_group_name                 = "io-p-rg-common"
log_analytics_workspace_name                = "io-p-law-common"
log_analytics_workspace_resource_group_name = "io-p-rg-common"
application_insights_name                   = "io-p-ai-common"

# Functions LolliPoP
cidr_subnet_fnlollipop              = ["10.0.17.0/26"]
cidr_subnet_fnlollipop_itn          = ["10.20.6.0/26"]
function_lollipop_kind              = "Linux"
function_lollipop_sku_size          = "P2mv3"
function_lollipop_autoscale_minimum = 3
function_lollipop_autoscale_maximum = 20
function_lollipop_autoscale_default = 10


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
cidr_subnet_session_manager = ["10.0.149.0/26"]

# DNS
external_domain = "pagopa.it"
dns_zone_io     = "io"
