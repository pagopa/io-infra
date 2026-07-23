locals {
  prefix             = "io"
  env_short          = "p"
  location           = { westeurope = "westeurope", italynorth = "italynorth" }
  location_short     = { westeurope = "weu", italynorth = "itn" }
  project_itn        = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu        = "${local.prefix}-${local.env_short}-${local.location_short.westeurope}"
  project_weu_legacy = "${local.prefix}-${local.env_short}"

  resource_groups = {

    itn = {
      common   = "${local.project_itn}-common-rg-01"
      internal = "${local.project_itn}-common-rg-01"
    }
  }

  #   core                   = data.terraform_remote_state.core.outputs
  #   platform_core          = data.terraform_remote_state.platform_core.outputs
  #   platform_observability = data.terraform_remote_state.platform_observability.outputs
  #   platform_app_backend   = data.terraform_remote_state.platform_app_backend.outputs

  tags = {
    CostCenter   = "TS000 - Tecnologia e Servizi"
    CreatedBy    = "Terraform"
    Environment  = "Prod"
    BusinessUnit = "App IO"
    #Source         = "https://github.com/pagopa/io-infra/blob/main/src/platform/prod/app-routing/" TODO: change tags after mass import
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/common/prod"
    ManagementTeam = "IO Platform"
  }
}