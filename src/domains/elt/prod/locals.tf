locals {
  prefix      = "io"
  env_short   = "p"
  project     = "${local.prefix}-${local.env_short}"
  project_itn = "${local.prefix}-${local.env_short}-itn"

  location     = "westeurope"
  location_itn = "italynorth"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    BusinessUnit   = "App IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/elt/prod"
    ManagementTeam = "IO Platform"
  }
}
