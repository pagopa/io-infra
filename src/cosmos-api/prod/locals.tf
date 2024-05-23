locals {
  prefix             = "io"
  env_short          = "p"
  project            = "${local.prefix}-${local.env_short}"
  location           = "westeurope"
  secondary_location = "northeurope"

  resource_group_name_internal = "${local.project}-rg-internal"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra/blob/main/src/cosmos-api/prod"
  }

  cosmosdb_containers = [
    {
      name                  = "activations"
      partition_key_path    = "/fiscalCode"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name               = "change-feed-leases"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name               = "cqrs-leases"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 4000
      }
    },
    {
      name               = "leaseMessageStatusForMessageRetention"
      partition_key_path = "/_partitionKey"
      throughput         = 400
    },
    {
      name               = "leases-services"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name               = "leases-services-2"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name               = "logins"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name                  = "message-status"
      partition_key_path    = "/messageId"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 67000
      }
    },
    {
      name                  = "message-view"
      partition_key_path    = "/fiscalCode"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 30000
      }
    },
    {
      name                  = "messages"
      partition_key_path    = "/fiscalCode"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 46000
      }
    },
    {
      name                  = "notification-status"
      partition_key_path    = "/notificationId"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 15000
      }
    },
    {
      name                  = "notifications"
      partition_key_path    = "/messageId"
      partition_key_version = null
      throughput            = 3800
    },
    {
      name               = "operations-leases-services"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name                  = "pdnd-leases"
      partition_key_path    = "/_partitionKey"
      partition_key_version = 2
      autoscale_settings = {
        max_throughput = 2000
      }
    },
    {
      name                  = "profile-emails-leases"
      partition_key_path    = "/_partitionKey"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name               = "profile-emails-uniqueness-leases"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name                  = "profiles"
      partition_key_path    = "/fiscalCode"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 48000
      }
    },
    {
      name                  = "sender-services"
      partition_key_path    = "/recipientFiscalCode"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name                  = "services"
      partition_key_path    = "/serviceId"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 15000
      }
    },
    {
      name               = "services-cms--legacy-watcher-lease"
      partition_key_path = "/_partitionKey"
      throughput         = 400
    },
    {
      name               = "services-devportalservicedata-leases-001"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name                  = "services-preferences"
      partition_key_path    = "/fiscalCode"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 2000
      }
    },
    {
      name               = "services-subsmigrations-leases-002"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name               = "services-subsmigrations-leases-003"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name                  = "subscription-cidrs"
      partition_key_path    = "/subscriptionId"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 1000
      }
    },
    {
      name                  = "user-data-processing"
      partition_key_path    = "/fiscalCode"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 1000
      }
    },
  ]
}
