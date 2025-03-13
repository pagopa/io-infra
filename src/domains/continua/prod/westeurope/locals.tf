locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location = "westeurope"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    BusinessUnit   = "App IO"
    ManagementTeam = "IO Platform"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/continua/prod/westeurope"
  }
}
