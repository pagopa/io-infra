locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  # ITN
  apim_itn_name                = "${local.project}-itn-apim-01"
  apim_itn_resource_group_name = "${local.project}-itn-common-rg-01"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    BusinessUnit   = "App IO"
    ManagementTeam = "IO CDC"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/cdc/prod"
  }
}
