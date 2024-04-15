locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location                        = "westeurope"
  secondary_location_display_name = "North Europe"

  tags = {
    CostCenter     = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    Owner          = "IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/elt/prod/westeurope"
    ManagementTeam = "IO Platform"
  }
}
