locals {
  nonstandard = {
    weu = {
      cdne = "${var.project}-assets-cdn-endpoint"
      st   = "${var.project}-stcdnassets"
      cdnp = "${var.project}-assets-cdn-profile"
    }
  }
}

###Italy North
locals {
  prefix = "io"
  env_short = "p"
  domain = "assetscdn"
  instance_number = "01"
  itn_environment = {
    prefix          = local.prefix
    env_short       = local.env_short
    location        = var.location
    domain          = local.domain
    instance_number = local.instance_number
    }
}