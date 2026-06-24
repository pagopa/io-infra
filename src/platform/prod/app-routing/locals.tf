locals {
  prefix             = "io"
  env_short          = "p"
  location           = { westeurope = "westeurope", italynorth = "italynorth" }
  location_short     = { westeurope = "weu", italynorth = "itn" }
  project_itn        = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu        = "${local.prefix}-${local.env_short}-${local.location_short.westeurope}"
  project_weu_legacy = "${local.prefix}-${local.env_short}"

  tags = {
    CostCenter   = "TS000 - Tecnologia e Servizi"
    CreatedBy    = "Terraform"
    Environment  = "Prod"
    BusinessUnit = "App IO"
    Source       = "https://github.com/pagopa/io-infra/blob/main/src/common/prod"
    #Source         = "https://github.com/pagopa/io-infra/blob/main/src/platform/prod/core/" # TODO: Change tags after mass import
    ManagementTeam = "IO Platform"
  }
}