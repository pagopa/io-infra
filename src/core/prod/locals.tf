locals {
  prefix                   = "io"
  env_short                = "p"
  location_short           = "itn"
  secondary_location_short = "gwc"
  project                  = "${local.prefix}-${local.env_short}-${local.location_short}"
  secondary_project        = "${local.prefix}-${local.env_short}-${local.secondary_location_short}"

  location           = "italynorth"
  secondary_location = "germanywestcentral"
  vnet_cidr_block    = "10.20.0.0/16"
  pep_snet_cidr      = ["10.20.2.0/23"]

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra/blob/main/src/core/prod/italynorth"
  }
}
