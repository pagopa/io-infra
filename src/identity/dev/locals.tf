locals {
  prefix    = "io"
  env_short = "d"
  env       = "dev"
  location  = "italynorth"
  project   = "${local.prefix}-${local.env_short}"
  domain    = "infra"

  repo_name = "io-infra"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Dev"
    BusinessUnit   = "App IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/identity/dev"
    ManagementTeam = "IO Platform"
  }
}
