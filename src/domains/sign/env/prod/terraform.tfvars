prefix    = "io"
env_short = "p"
domain    = "sign"
location  = "westeurope"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "IO"
  Source      = "https://github.com/pagopa/io-infra/src/sign"
  CostCenter  = "BD100 - STRATEGIC INNOVATION"
}

storage = {
  enable_versioning = false
  delete_after_days = 90
  replication_type  = "GZRS"
}

cosmos = {
  zone_redundant = true
}

io_sign_database_issuer = {
  dossiers = {
    # TODO [SFEQS-1200] Refactor terraform provider to v3
    max_throughput = 1000
    ttl            = null
  }
  signature_requests = {
    # TODO [SFEQS-1200] Refactor terraform provider to v3
    max_throughput = 1000
    ttl            = null
  }
  uploads = {
    # TODO [SFEQS-1200] Refactor terraform provider to v3
    max_throughput = 1000
    ttl            = 604800
  }
}

io_sign_database_user = {
  signature_requests = {
    # TODO [SFEQS-1200] Refactor terraform provider to v3
    max_throughput = 1000
    ttl            = null
  }
  signatures = {
    # TODO [SFEQS-1200] Refactor terraform provider to v3
    max_throughput = 1000
    ttl            = null
  }
}

io_sign_issuer_func = {
  sku_tier          = "PremiumV3"
  sku_size          = "P1v3"
  autoscale_default = 1
  autoscale_minimum = 1
  autoscale_maximum = 5
}

io_sign_user_func = {
  sku_tier          = "PremiumV3"
  sku_size          = "P1v3"
  autoscale_default = 1
  autoscale_minimum = 1
  autoscale_maximum = 5
}
