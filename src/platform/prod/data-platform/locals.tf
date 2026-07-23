locals {
  prefix             = "io"
  env_short          = "p"
  location           = { westeurope = "westeurope", italynorth = "italynorth" }
  location_short     = { westeurope = "weu", italynorth = "itn" }
  project_itn        = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu        = "${local.prefix}-${local.env_short}-${local.location_short.westeurope}"
  project_weu_legacy = "${local.prefix}-${local.env_short}"

  resource_groups = {

    itn = {
      internal = "${local.project_itn}-common-rg-01"
    }
    weu = {
      common = "${local.project_weu_legacy}-rg-common"
      event  = "${local.project_weu_legacy}-evt-rg"
    }
  }

  core                   = data.terraform_remote_state.core.outputs
  platform_core          = data.terraform_remote_state.platform_core.outputs
  platform_observability = data.terraform_remote_state.platform_observability.outputs

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

  tags = {
    CostCenter   = "TS000 - Tecnologia e Servizi"
    CreatedBy    = "Terraform"
    Environment  = "Prod"
    BusinessUnit = "App IO"
    #Source         = "https://github.com/pagopa/io-infra/blob/main/src/platform/prod/app-routing/" TODO: change tags after mass import
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/common/prod"
    ManagementTeam = "IO Platform"
  }
}