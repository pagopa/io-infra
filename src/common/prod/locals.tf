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
    Source      = "https://github.com/pagopa/io-infra/blob/main/src/common/prod"
  }

  core = data.terraform_remote_state.core.outputs

  function_app_count = 2

  # TODO: edit this block when resource groups module is implemented
  resource_groups = {
    weu = {
      common   = "${local.project_weu_legacy}-rg-common"
      internal = "${local.project_weu_legacy}-rg-internal"
      external = "${local.project_weu_legacy}-rg-external"
      event    = "${local.project_weu_legacy}-evt-rg"
      sec      = "${local.project_weu_legacy}-sec-rg"
      linux    = "${local.project_weu_legacy}-rg-linux"
    }

    itn = {
      common   = "${local.project_itn}-common-rg-01"
      internal = "${local.project_itn}-common-rg-01"
      external = "${local.project_itn}-common-rg-01"
      event    = "${local.project_itn}-common-rg-01"
      sec      = "${local.project_itn}-sec-rg-01"
      linux    = "${local.project_itn}-common-rg-01"
    }
  }

  cosmos_api = {
    allowed_subnets = ["fn3admin", "fn3app1", "fn3app2", "fn3appasync", "fn3assets", "fn3public", "fn3services", "fn3slackbot"]
  }

  app_backends = {
    l1 = {
      cidr_subnet = ["10.0.152.0/24"]
      app_settings_override = {
        IS_APPBACKENDLI = "false"
        // FUNCTIONS
        API_URL              = "https://${data.azurerm_linux_function_app.function_app[1].default_hostname}/api/v1"
        APP_MESSAGES_API_URL = format("https://io-p-itn-msgs-citizen-func-01.azurewebsites.net/api/v1")
      }
    },
    l2 = {
      cidr_subnet = ["10.0.153.0/24"]
      app_settings_override = {
        IS_APPBACKENDLI = "false"
        // FUNCTIONS
        API_URL              = "https://${data.azurerm_linux_function_app.function_app[1].default_hostname}/api/v1"
        APP_MESSAGES_API_URL = format("https://io-p-itn-msgs-citizen-func-02.azurewebsites.net/api/v1")
      }
    }
  }

  app_backendli = {
    cidr_subnet = ["10.0.154.0/24"]
    app_settings_override = {
      IS_APPBACKENDLI = "true"
      // FUNCTIONS
      API_URL              = "https://${data.azurerm_linux_function_app.function_app[1].default_hostname}/api/v1" # not used
      APP_MESSAGES_API_URL = "https://io-p-itn-msgs-citizen-func-01.azurewebsites.net/api/v1"                     # not used
    }
  }

  functions = {
    assets_cdn           = data.azurerm_linux_function_app.function_assets_cdn
    services_app_backend = data.azurerm_linux_function_app.services_app_backend_function_app
    lollipop             = data.azurerm_linux_function_app.lollipop_function
    eucovidcert          = data.azurerm_linux_function_app.eucovidcert
    cgn                  = data.azurerm_linux_function_app.function_cgn
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