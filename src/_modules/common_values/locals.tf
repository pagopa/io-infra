locals {
  prefix    = "io"
  env_short = "p"
  location_short = {
    westeurope         = "weu",
    italynorth         = "itn",
    germanywestcentral = "gwc",
    northeurope        = "neu"
  }
  project_itn        = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu        = "${local.prefix}-${local.env_short}-${local.location_short.westeurope}"
  project_weu_legacy = "${local.prefix}-${local.env_short}"
  common             = data.terraform_remote_state.common.outputs
}