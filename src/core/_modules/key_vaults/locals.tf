locals {
  nonstandard = {
    weu = {
      rg        = "${var.project}-sec-rg"
      kv        = "${var.project}-kv"
      kv_common = "${var.project}-kv-common"
    }
  }
}
