locals {
  nonstandard = {
    weu = {
      cdne = "${var.project}-assets-cdn-endpoint"
      st   = "${var.project}-stcdnassets"
      cdnp = "${var.project}-assets-cdn-profile"
    }
    itn = {
      cdne = "${var.project}-assets-cdn-endpoint"
      st   = "${var.project}-stcdnassets"
      cdnp = "${var.project}-assets-cdn-profile"
    }
  }
}
