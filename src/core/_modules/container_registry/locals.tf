locals {
  nonstandard = {
    weu = {
      rg  = "${var.project}-container-registry-rg"
      acr = replace("${var.project}-common-acr", "-", "")
    }
  }
}
