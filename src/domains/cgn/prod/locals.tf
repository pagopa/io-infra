locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location           = "westeurope"
  secondary_location = "italynorth"

  itn_environment = {
    prefix          = local.prefix
    env_short       = local.env_short
    location        = local.secondary_location
    domain          = "cgn"
    instance_number = "01"
  }

  tags = {
    CostCenter     = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    Owner          = "IO"
    ManagementTeam = "IO Enti & Servizi"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/cgn/prod"
  }
}
