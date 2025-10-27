locals {
  ip_range_filter = toset(["52.174.88.118", "40.91.208.65", "13.69.64.208/28", "13.69.71.192/27", "13.93.36.78", "20.86.93.32/27", "20.86.93.64/28", "20.126.243.151", "20.126.241.238", "20.103.132.139", "20.103.131.1"])
  cosmosdb_containers = [
    {
      name                  = "activations"
      partition_key_path    = "/fiscalCode"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 7000
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
      default_ttl           = -1
      autoscale_settings = {
        max_throughput = 180000
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
      default_ttl           = -1
      autoscale_settings = {
        max_throughput = 80000
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

      autoscale_settings = {
        max_throughput = 14000
      }
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
      name               = "profile-emails-uniqueness-leases-itn"
      partition_key_path = "/_partitionKey"
      autoscale_settings = {
        max_throughput = 2000
      }
    },
    {
      name               = "profile-emails-uniqueness-leases-itn-002",
      partition_key_path = "/id",
      autoscale_settings = {
        max_throughput = 2000
      }
    },
    {
      name                  = "profiles"
      partition_key_path    = "/fiscalCode"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 80000
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
        max_throughput = 45000
      }
    },
    {
      name               = "services-cms--legacy-watcher-lease"
      partition_key_path = "/_partitionKey"
      throughput         = 400
    },
    {
      name                  = "services-preferences"
      partition_key_path    = "/fiscalCode"
      partition_key_version = null
      autoscale_settings = {
        max_throughput = 8000
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
