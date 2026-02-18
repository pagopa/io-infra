locals {
  prefix             = "io"
  env_short          = "p"
  project_weu_legacy = "${local.prefix}-${local.env_short}"
    tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    BusinessUnit   = "App IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/platform/westeurope/storage/prod"
    ManagementTeam = "IO Platform"
  }
  
  core = data.terraform_remote_state.core.outputs

}