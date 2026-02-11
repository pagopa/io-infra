locals {
  prefix    = "io"
  env_short = "d"
  location  = "italynorth"
  project   = "${local.prefix}-${local.env_short}-itn"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Dev"
    BusinessUnit   = "App IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/common/dev"
    ManagementTeam = "IO Platform"
  }
}
