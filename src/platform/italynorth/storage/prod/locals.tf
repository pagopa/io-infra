locals {
  prefix         = "io"
  env_short      = "p"
  location_short = { westeurope = "weu", italynorth = "itn", germanywestcentral = "gwc", northeurope = "neu" }
  project_itn    = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  tags = {
    CostCenter   = "TS000 - Tecnologia e Servizi"
    CreatedBy    = "Terraform"
    Environment  = "Prod"
    BusinessUnit = "App IO"
    Source       = "https://github.com/pagopa/io-infra/blob/main/src/common/prod" # TODO: change tag to reflect the current path
    # Source         = "https://github.com/pagopa/io-infra/blob/main/src/platform/italynorth/storage/prod"
    ManagementTeam = "IO Platform"
  }

  core = data.terraform_remote_state.core.outputs

}