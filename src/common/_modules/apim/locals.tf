locals {
  nonstandard = {
    weu = {
      snet_name = "apimv2api"
      nsg_name  = "${var.project}-apim-v2-nsg"
      pip_name  = "${var.project}-apim-v2-public-ip"
      apim_name = "${var.project}-apim-v2-api"
    }
  }
}
