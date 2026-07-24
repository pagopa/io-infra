locals {
  nonstandard = {
    weu = {
      subnet          = "rediscommon"
      redis_common    = "${var.project}-redis-common"
      storage_account = replace(format("%s-stredisbackup", var.project), "-", "")
    }
  }
}
