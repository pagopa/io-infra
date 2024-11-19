locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location           = "westeurope"
  secondary_location = "italynorth"

  # WEU
  apim_v2_name             = "${local.project}-apim-v2-api"
  apim_resource_group_name = "${local.project}-rg-internal"
  # ITN
  apim_itn_name                = "${local.project}-itn-apim-01"
  apim_itn_resource_group_name = "${local.project}-itn-common-rg-01"

  tags = {
    CostCenter     = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    Owner          = "IO"
    ManagementTeam = "IO Enti & Servizi"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/cgn/prod"
  }
}
