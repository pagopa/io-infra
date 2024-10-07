locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location           = "westeurope"
  secondary_location = "italynorth"

  tags = {
    CostCenter     = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    Owner          = "IO"
    ManagementTeam = "IO Enti & Servizi"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/cgn/prod"
  }
}
