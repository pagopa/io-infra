prefix          = "io"
env_short       = "p"
env             = "prod"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/tree/main/src/messages"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

log_workspace_name = "io-p-law-common"
log_workspace_rg = "io-p-rg-common"
rg_name = "io-p-opex-test"
