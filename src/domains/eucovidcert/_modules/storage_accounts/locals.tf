###Italy North
locals {
  prefix = "io"
  env_short = "p"
  domain = "eucovidcert"
  instance_number = "01"
  itn_environment = {
    prefix          = local.prefix
    env_short       = local.env_short
    location        = var.location
    domain          = local.domain
    instance_number = local.instance_number
    }
}