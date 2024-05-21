env_short = "p"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

location       = "westeurope"
location_short = "weu"
lock_enable    = true

# networking
# check free subnet on azure portal io-p-vnet-common -> subnets
cidr_subnet_fnadmin     = ["10.0.15.0/26"]
cidr_subnet_shared_1    = ["10.0.16.0/26"]
cidr_subnet_fncdnassets = ["10.0.131.0/24"]
cidr_subnet_app         = ["10.0.132.0/26", "10.0.132.64/26"]
cidr_subnet_app_async   = ["10.0.132.128/26"]
cidr_subnet_services    = ["10.0.139.0/26", "10.0.139.64/26"]

# Functions App
function_app_kind              = "Linux"
function_app_sku_tier          = "PremiumV3"
function_app_sku_size          = "P1v3"
function_app_autoscale_minimum = 2
function_app_autoscale_maximum = 30
function_app_autoscale_default = 10

# Functions Services
function_services_kind              = "Linux"
function_services_sku_tier          = "PremiumV3"
function_services_sku_size          = "P1v3"
function_services_autoscale_minimum = 1
function_services_autoscale_maximum = 30
function_services_autoscale_default = 10

# Functions App Async
function_app_async_kind              = "Linux"
function_app_async_sku_tier          = "PremiumV3"
function_app_async_sku_size          = "P1v3"
function_app_async_autoscale_minimum = 3 # 2 instance to achieve redundancy and failover
function_app_async_autoscale_maximum = 30
function_app_async_autoscale_default = 10

# Functions Admin
function_admin_kind              = "Linux"
function_admin_sku_tier          = "PremiumV3"
function_admin_sku_size          = "P1v3"
function_admin_autoscale_minimum = 1
function_admin_autoscale_maximum = 3
function_admin_autoscale_default = 1

# Functions shared
plan_shared_1_kind                = "Linux"
plan_shared_1_sku_tier            = "PremiumV3"
plan_shared_1_sku_size            = "P1v3"
function_public_autoscale_minimum = 1
function_public_autoscale_maximum = 30
function_public_autoscale_default = 10


# Function CDN Assets
function_assets_cdn_kind              = "Linux"
function_assets_cdn_sku_tier          = "PremiumV3"
function_assets_cdn_sku_size          = "P1v3"
function_assets_cdn_autoscale_minimum = 1
function_assets_cdn_autoscale_maximum = 5
function_assets_cdn_autoscale_default = 1

# PN Service Id
pn_service_id = "01G40DWQGKY5GRWSNM4303VNRP"
