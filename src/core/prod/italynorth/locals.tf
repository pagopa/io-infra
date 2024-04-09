locals {
  prefix                   = "io"
  env_short                = "p"
  location_short           = "in"
  secondary_location_short = "gw"
  project                  = "${local.prefix}-${local.env_short}-${location_short}"
  secondary_project        = "${local.prefix}-${local.env_short}-${secondary_location_short}"

  location           = "italynorth"
  secondary_location = "westgermany"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra/blob/main/src/core/prod/italynorth"
  }
}
