locals {
  prefix                   = "io"
  env_short                = "p"
  location                 = "italynorth"
  location_short           = "itn"
  secondary_location       = "germanywestcentral"
  secondary_location_short = "gwc"
  domain                   = "bonus"
  project                  = "${local.prefix}-${local.env_short}-${local.location_short}-${local.domain}"
  secondary_project        = "${local.prefix}-${local.env_short}-${local.secondary_location_short}-${local.domain}"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    BusinessUnit   = "App IO"
    ManagementTeam = "IO Bonus & Pagamenti"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/bonus/prod"
  }
}
