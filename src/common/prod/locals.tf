locals {
  prefix             = "io"
  env_short          = "p"
  location_short     = { westeurope = "weu", italynorth = "itn", germanywestcentral = "gwc", northeurope = "neu" }
  project_itn        = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu        = "${local.prefix}-${local.env_short}-${local.location_short.westeurope}"
  project_weu_legacy = "${local.prefix}-${local.env_short}"
  secondary_project  = "${local.prefix}-${local.env_short}-${local.location_short.germanywestcentral}"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    BusinessUnit   = "App IO"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/common/prod"
    ManagementTeam = "IO Platform"
  }

  core = data.terraform_remote_state.core.outputs

  app_messages_count = 2

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
    allowed_subnets = []
  }

  app_backends = {
    1 = {
      cidr_subnet = ["10.0.152.0/24"]
    },
    2 = {
      cidr_subnet = ["10.0.153.0/24"]
    },
  }

  azdoa_snet_id = {
    weu = local.core.azure_devops_agent["weu"].snet.id
    itn = null
  }

  backend_hostnames = {
    app                  = [data.azurerm_linux_function_app.function_profile.default_hostname]
    com_citizen_func     = data.azurerm_linux_function_app.com_citizen_func.default_hostname
    assets_cdn           = data.azurerm_linux_function_app.function_assets_cdn.default_hostname
    services_app_backend = data.azurerm_linux_function_app.services_app_backend_function_app.default_hostname
    lollipop             = data.azurerm_linux_function_app.lollipop_function.default_hostname
    eucovidcert          = data.azurerm_linux_function_app.eucovidcert.default_hostname
    cgn                  = "io-p-itn-cgn-card-func-02.azurewebsites.net"
    iosign               = data.azurerm_linux_function_app.io_sign_user.default_hostname
    iofims               = data.azurerm_linux_function_app.io_fims_user.default_hostname
    cgnonboarding        = "io-p-itn-cgn-search-func-02.azurewebsites.net"
    iowallet             = data.azurerm_linux_function_app.wallet_user.default_hostname
    iowalletuat          = data.azurerm_linux_function_app.wallet_user_uat.default_hostname
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
