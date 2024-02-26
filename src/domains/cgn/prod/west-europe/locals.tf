locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location = "westeurope"

  tags = {
    test = "io-infra-refactoring"
  }
}
