locals {
  nonstandard = {
    weu = {
      cdne = "${var.project}-assets-cdn-endpoint"
      rg   = "${var.project}-assets-cdn-rg"
      st   = "${var.project}-stcdnassets"
      cdnp = "${var.project}-assets-cdn-profile"
    }
  }
}