prefix          = "io"
env_short       = "p"
env             = "prod"
domain          = "aks-prod-01"
location        = "westeurope"
location_short  = "weu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/src/sign"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

container_registry_enabled = true
