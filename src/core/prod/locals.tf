locals {
  prefix             = "io"
  env_short          = "p"
  location_short     = { westeurope = "weu", italynorth = "itn", germanywestcentral = "gwc", northeurope = "neu" }
  project_itn        = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu_legacy = "${local.prefix}-${local.env_short}"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    BusinessUnit   = "App IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/core/prod"
    ManagementTeam = "IO Platform"
  }

  platform_observability = data.terraform_remote_state.platform_observability.outputs
}
