locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location           = "westeurope"
  secondary_location = "northeurope"

  tags = {
    test = "io-infra-refactoring"
  }
}
