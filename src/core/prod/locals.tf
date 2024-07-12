locals {
  prefix                   = "io"
  env_short                = "p"
  location_short           = { westeurope = "weu", italynorth = "itn" }
  secondary_location_short = "gwc"
  project_itn              = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu              = "${local.prefix}-${local.env_short}-${local.location_short.westeurope}"
  project_weu_legacy       = "${local.prefix}-${local.env_short}"
  secondary_project        = "${local.prefix}-${local.env_short}-${local.secondary_location_short}"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra/blob/main/src/core/prod"
  }
}
