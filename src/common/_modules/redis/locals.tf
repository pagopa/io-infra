locals {
  nonstandard = {
    weu = {
      subnet          = "rediscommon"
      redis_common    = "${var.project}-redis-common"
      storage_account = replace(format("%s-stredisbackup", var.project), "-", "")
    }
  }
}

###Italy North
locals {
  prefix    = "io"
  env_short = "p"
  # domain          = "redis"
  app_name        = "redis"
  instance_number = "01"
  itn_environment = {
    prefix    = local.prefix
    env_short = local.env_short
    location  = var.location
    app_name  = local.app_name
    # domain          = local.domain
    instance_number = local.instance_number
  }
}
