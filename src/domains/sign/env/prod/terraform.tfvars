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

# Container App Job GitHub Runner
key_vault_common = {
  resource_group_name = "io-p-rg-common"
  name                = "io-p-kv-common"
  pat_secret_name     = "github-runner-pat"
}

container_app_environment = {
  name                = "io-p-github-runner-cae"
  resource_group_name = "io-p-github-runner-rg"
}

# You can retrieve the list of current defined subnets using the CLI command
# az network vnet subnet list --subscription PROD-IO --vnet-name io-p-vnet-common --resource-group io-p-rg-common --output table
# and thus define new CIDRs according to the unallocated address space
subnets_cidrs = {
  issuer     = ["10.0.102.0/24"]
  user       = ["10.0.103.0/24"]
  eventhub   = ["10.0.104.0/24"],
  support    = ["10.0.147.0/24"]
  backoffice = ["10.0.115.0/24"]
}

storage_account = {
  enable_versioning             = false
  delete_after_days             = 90
  replication_type              = "GZRS"
  enable_low_availability_alert = true
}

cosmos = {
  zone_redundant = false
  additional_geo_locations = [
    {
      location          = "northeurope"
      failover_priority = 1
      zone_redundant    = false
    }
  ]
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

io_sign_database_backoffice = {
  api_keys = {
    max_throughput = 1000
    ttl            = null
  }
  api_keys_by_id = {
    max_throughput = 1000
    ttl            = null
  }
  issuers = {
    max_throughput = 1000
    ttl            = null
  }
  consents = {
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

io_sign_support_func = {
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

io_sign_backoffice_app = {
  sku_name = "P1v3"
  app_settings = [
    {
      name  = "NODE_ENV",
      value = "production"
    },
    {
      name  = "HOSTNAME",
      value = "0.0.0.0"
    },
    {
      name  = "WEBSITE_RUN_FROM_PACKAGE",
      value = "1"
    },
    {
      name                  = "AUTH_SESSION_SECRET",
      key_vault_secret_name = "bo-auth-session-secret"
    },
    {
      name                  = "SELFCARE_API_KEY",
      key_vault_secret_name = "selfcare-prod-api-key"
    },
    {
      name                  = "PDV_TOKENIZER_API_KEY"
      key_vault_secret_name = "pdv-tokenizer-api-key"
    },
    {
      name                  = "SLACK_WEB_HOOK_URL",
      key_vault_secret_name = "slack-webhook-url"
    }
  ]
}

io_sign_backoffice_func = {
  autoscale_default = 1
  autoscale_minimum = 1
  autoscale_maximum = 3
  app_settings = [
    {
      name  = "NODE_ENV",
      value = "production"
    },
    {
      name  = "SELFCARE_EVENT_HUB_CONTRACTS_NAME",
      value = "sc-contracts"
    },
    {
      name  = "BACK_OFFICE_API_BASE_PATH"
      value = "https://api.io.pagopa.it/api/v1/sign/backoffice"
    },
    {
      name                  = "SelfCareEventHubConnectionString",
      key_vault_secret_name = "SelfCareEventHubConnectionString"
    },
    {
      name                  = "SLACK_WEBHOOK_URL",
      key_vault_secret_name = "slack-webhook-url"
    },
    {
      name                  = "BACK_OFFICE_API_KEY"
      key_vault_secret_name = "BackOfficeApiKey"
    },
    {
      name                  = "GOOGLE_PRIVATE_KEY",
      key_vault_secret_name = "bo-google-private-key"
    },
    {
      name                  = "GOOGLE_CLIENT_EMAIL",
      key_vault_secret_name = "bo-google-client-email"
    },
    {
      name                  = "GOOGLE_SPREADSHEET_ID",
      key_vault_secret_name = "bo-google-spreadsheet-id"
    },
    {
      name                  = "SELFCARE_API_KEY",
      key_vault_secret_name = "selfcare-prod-api-key"
    },
  ]
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
    },
    {
      ip_mask = "18.159.227.69", # PDND-DATALAKE
      action  = "Allow"
    },
    {
      ip_mask = "3.126.198.129", # PDND-DATALAKE
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

# DNS

dns_zone_names = {
  website = "firma.io.pagopa.it"
}

dns_ses_validation = [
  {
    name   = "usgxww7qq2vgfzl4da6yv4qb4f7ls5kq._domainkey"
    record = "usgxww7qq2vgfzl4da6yv4qb4f7ls5kq.dkim.amazonses.com"
  },
  {
    name   = "e4m2laccz356yraixvndjtoivkwf4sc2._domainkey"
    record = "e4m2laccz356yraixvndjtoivkwf4sc2.dkim.amazonses.com"
  },
  {
    name   = "43al7wmot7uxzzz6dfq7fnkcqilx6q6l._domainkey"
    record = "43al7wmot7uxzzz6dfq7fnkcqilx6q6l.dkim.amazonses.com"
  },
]

io_common = {
  resource_group_name          = "io-p-rg-common"
  log_analytics_workspace_name = "io-p-law-common"
  appgateway_snet_name         = "io-p-appgateway-snet"
  vnet_common_name             = "io-p-vnet-common"
}
