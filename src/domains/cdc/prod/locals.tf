locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  # ITN
  apim_itn_name                = "${local.project}-itn-apim-01"
  apim_itn_resource_group_name = "${local.project}-itn-common-rg-01"
}
