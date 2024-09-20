removed {
  from = module.redis_common_backup_zrs
  lifecycle {
    destroy = false
  }
}

removed {
  from = module.redis_common_snet
  lifecycle {
    destroy = false
  }
}
