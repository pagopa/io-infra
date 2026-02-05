env_short = "p"

tags = {
  BusinessUnit = "App IO"
  CreatedBy    = "Terraform"
  Environment  = "Prod"
  Source       = "https://github.com/pagopa/io-infra/blob/main/src/domains/functions"
  CostCenter   = "TS000 - Tecnologia e Servizi"
}

location       = "westeurope"
location_short = "weu"
lock_enable    = true

# networking
# check free subnet on azure portal io-p-vnet-common -> subnets
cidr_subnet_shared_1    = ["10.0.16.0/26"]
cidr_subnet_fncdnassets = ["10.0.131.0/24"]
cidr_subnet_services    = ["10.0.139.0/26", "10.0.139.64/26"]

# Functions Services
function_services_kind              = "Linux"
function_services_sku_tier          = "PremiumV3"
function_services_sku_size          = "P1v3"
function_services_autoscale_minimum = 3
function_services_autoscale_maximum = 30
function_services_autoscale_default = 10

# Function CDN Assets
function_assets_cdn_kind              = "Linux"
function_assets_cdn_sku_tier          = "PremiumV3"
function_assets_cdn_sku_size          = "P1v3"
function_assets_cdn_autoscale_minimum = 1
function_assets_cdn_autoscale_maximum = 5
function_assets_cdn_autoscale_default = 1

# PN Service Id
pn_service_id = "01G40DWQGKY5GRWSNM4303VNRP"
