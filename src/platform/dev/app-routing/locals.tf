locals {
  prefix    = "io"
  env_short = "d"
  location  = "italynorth"
  project   = "${local.prefix}-${local.env_short}-itn"

  project_itn = "${local.prefix}-${local.env_short}-${local.location_short}"

  location_short = "itn"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Dev"
    BusinessUnit   = "App IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/platform/dev/app-routing/"
    ManagementTeam = "IO Platform"
  }
}
