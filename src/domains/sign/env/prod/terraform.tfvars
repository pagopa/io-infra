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
  replication_type  = "ZRS"
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
}

io_sign_issuer_func = {
  version = "io-func-sign-issuer-0.9.1"
  # TODO(SFEQS-1194) Set recommended production values
  sku_tier = "Basic"
  sku_size = "B1"
}

io_sign_user_func = {
  version = "io-func-sign-user-0.1.0"
  # TODO(SFEQS-1194) Set recommended production values
  sku_tier = "Basic"
  sku_size = "B1"
}
