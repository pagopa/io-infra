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

subnets_cidrs = {
  issuer   = ["10.0.102.0/24"]
  user     = ["10.0.103.0/24"]
  eventhub = ["10.0.104.0/24"]
}

storage_account = {
  enable_versioning             = false
  delete_after_days             = 90
  replication_type              = "GZRS"
  enable_low_availability_alert = true
}

cosmos = {
  # TODO Temporarely disabled due to ServiceUnavailable error
  zone_redundant = false
}

io_sign_database_issuer = {
  dossiers = {
    max_throughput = 1000
    ttl            = null
  }
  signature_requests = {
    max_throughput = 1000
    ttl            = null
  }
  uploads = {
    max_throughput = 1000
    ttl            = 604800
  }
  issuers = {
    max_throughput = 1000
    ttl            = null
  }
}

io_sign_database_user = {
  signature_requests = {
    max_throughput = 1000
    ttl            = null
  }
  signatures = {
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

integration_hub = {
  auto_inflate_enabled     = true
  sku_name                 = "Standard"
  capacity                 = 1
  maximum_throughput_units = 5
  zone_redundant           = true
  alerts_enabled           = true
  ip_rules = [
    {
      ip_mask = "18.192.147.151", # PDND-DATALAKE
      action  = "Allow"
    }
  ]
  hubs = [
    {
      name              = "billing"
      partitions        = 3
      message_retention = 7
      consumers         = []
      keys = [
        {
          name   = "io-sign-func-issuer"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "pdnd-invoicing"
          listen = true
          send   = false
          manage = false
        }
      ]
    },
    {
      name              = "analytics"
      partitions        = 3
      message_retention = 7
      consumers         = []
      keys = [
        {
          name   = "io-sign-func-user"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "io-sign-func-issuer"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "pdnd-invoicing"
          listen = true
          send   = false
          manage = false
        }
      ]
    }
  ]
}
