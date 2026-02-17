locals {
  prefix         = "io"
  env_short      = "p"
  legacy_project = "${local.prefix}-${local.env_short}"
  project        = "${local.legacy_project}-${local.legacy_location_short}"

  legacy_location_short = "weu"
  legacy_location       = "westeurope"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    ManagementTeam = "IO Platform"
    BusinessUnit   = "App IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/load-test/prod"
  }
}
