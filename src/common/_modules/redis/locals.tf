locals {
  nonstandard = {
    weu = {
      subnet          = "rediscommon"
      redis_common    = "io-p-redis-common"
      storage_account = replace(format("%s-stredisbackup", var.project), "-", "")
    }
  }
}
