locals {
  prefix             = "io"
  env_short          = "p"
  location_short     = { westeurope = "weu", italynorth = "itn", germanywestcentral = "gwc", northeurope = "neu" }
  project_itn        = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu        = "${local.prefix}-${local.env_short}-${local.location_short.westeurope}"
  project_weu_legacy = "${local.prefix}-${local.env_short}"
  secondary_project  = "${local.prefix}-${local.env_short}-${local.location_short.germanywestcentral}"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra/blob/main/src/core/prod"
  }

  eventhubs = [
    {
      name              = "io-cosmosdb-services"
      partitions        = 5
      message_retention = 7
      consumers         = []
      keys = [
        {
          name   = "io-fn-elt"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "pdnd"
          listen = true
          send   = false
          manage = false
        }
      ]
    },
    {
      name              = "io-cosmosdb-profiles"
      partitions        = 5
      message_retention = 7
      consumers         = []
      keys = [
        {
          name   = "io-fn-elt"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "pdnd"
          listen = true
          send   = false
          manage = false
        }
      ]
    },
    {
      name              = "import-command"
      partitions        = 2
      message_retention = 7
      consumers         = []
      keys = [
        {
          name   = "ops"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "io-fn-elt"
          listen = true
          send   = false
          manage = false
        }
      ]
    },
    {
      name              = "io-cosmosdb-message-status"
      partitions        = 32
      message_retention = 7
      consumers         = ["io-messages"]
      keys = [
        {
          name   = "io-cdc"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "io-messages"
          listen = true
          send   = false
          manage = false
        }
      ]
    },
    {
      name              = "pdnd-io-cosmosdb-messages"
      partitions        = 30
      message_retention = 7
      consumers         = []
      keys = [
        {
          name   = "io-fn-elt"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "pdnd"
          listen = true
          send   = false
          manage = false
        }
      ]
    },
    {
      name              = "pdnd-io-cosmosdb-message-status"
      partitions        = 30
      message_retention = 7
      consumers         = []
      keys = [
        {
          name   = "io-fn-elt"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "pdnd"
          listen = true
          send   = false
          manage = false
        }
      ]
    },
    {
      name              = "pdnd-io-cosmosdb-service-preferences"
      partitions        = 30
      message_retention = 7
      consumers         = []
      keys = [
        {
          name   = "io-fn-elt"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "pdnd"
          listen = true
          send   = false
          manage = false
        }
      ]
    },
    {
      name              = "pdnd-io-cosmosdb-notification-status"
      partitions        = 30
      message_retention = 7
      consumers         = []
      keys = [
        {
          name   = "io-fn-elt"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "pdnd"
          listen = true
          send   = false
          manage = false
        }
      ]
    },
    {
      name              = "io-cosmosdb-message-status-for-view"
      partitions        = 32
      message_retention = 7
      consumers         = ["io-messages"]
      keys = [
        {
          name   = "io-cdc"
          listen = false
          send   = true
          manage = false
        },
        {
          name   = "io-messages"
          listen = true
          send   = false
          manage = false
        }
      ]
    }
  ]
}
