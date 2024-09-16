locals {
  nonstandard = {
    weu = {
      rg          = "${var.project}-azdoa-rg"
      snet        = "azure-devops"
      li_infra    = "${var.project}-azdoa-vmss-li-infra"
      li_loadtest = "${var.project}-azdoa-vmss-loadtest-li"
    }
  }

  image_name = "azdo-agent-ubuntu2204-image-v2"
}