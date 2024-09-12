locals {
  prefix      = "io"
  env_short   = "p"
  project     = "${local.prefix}-${local.env_short}"
  project_itn = "${local.prefix}-${local.env_short}-itn"

  location                        = "westeurope"
  secondary_location_display_name = "North Europe"

  location_itn = "italynorth"

  tags = {
    CostCenter     = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    Owner          = "IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/elt/prod"
    ManagementTeam = "IO Platform"
  }
}
