locals {
  prefix         = "io"
  env_short      = "d"
  location_short = { westeurope = "weu", italynorth = "itn", germanywestcentral = "gwc", northeurope = "neu" }
  project_itn    = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Dev"
    BusinessUnit   = "App IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/core/dev"
    ManagementTeam = "IO Platform"
  }
}
