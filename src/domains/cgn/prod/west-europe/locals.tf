locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location           = "westeurope"
  secondary_location = "northeurope"

  tags = {
    CostCenter = "io-infra-refactoring"
    CreatedBy = "Terraform"
    Environment = "Prod"
    Owner = "IO"
    Source = "https://github.com/pagopa/io-infra/blob/main/src/domains/cgn/prod/west-europe"
  }
}
