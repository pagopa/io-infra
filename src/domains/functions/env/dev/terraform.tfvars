env_short = "d"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

location       = "westeurope"
location_short = "weu"
common_rg = "io-p-rg-common"

## Network
vnet_name = "io-p-vnet-common"