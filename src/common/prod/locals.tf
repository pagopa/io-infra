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
    3 = {
      cidr_subnet = ["10.0.154.0/24"]
    },
  }

  azdoa_snet_id = {
    weu = local.core.azure_devops_agent["weu"].snet.id
    itn = null
  }

  backend_hostnames = {
    app              = [data.azurerm_linux_function_app.function_profile.default_hostname]
    com_citizen_func = data.azurerm_linux_function_app.com_citizen_func.default_hostname
    assets_cdn       = data.azurerm_linux_function_app.function_assets_cdn.default_hostname
    # services_app_backend = data.azurerm_linux_function_app.services_app_backend_function_app.default_hostname
    services_app_backend = data.azurerm_container_app.services_app_backend_function_app.ingress[0].fqdn
    lollipop             = data.azurerm_linux_function_app.lollipop_function.default_hostname
    eucovidcert          = data.azurerm_linux_function_app.eucovidcert.default_hostname
    cgn                  = "io-p-itn-cgn-card-func-02.azurewebsites.net"
    iosign               = data.azurerm_linux_function_app.io_sign_user.default_hostname
    iofims               = data.azurerm_linux_function_app.io_fims_user.default_hostname
    cgnonboarding        = "io-p-itn-cgn-search-func-02.azurewebsites.net"
    iowallet             = data.azurerm_linux_function_app.wallet_user.default_hostname
    iowalletuat          = data.azurerm_linux_function_app.wallet_user_uat.default_hostname
    cdc_support          = "io-p-itn-cdc-support-func-01.azurewebsites.net"
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

  function_services = {
    rg_common_name     = format("%s-rg-common", local.project_weu_legacy)
    rg_internal_name   = format("%s-rg-internal", local.project_weu_legacy)
    rg_assets_cdn_name = format("%s-assets-cdn-rg", local.project_weu_legacy)

    tags = {
      BusinessUnit = "App IO"
      CreatedBy    = "Terraform"
      Environment  = "Prod"
      Source       = "https://github.com/pagopa/io-infra/blob/main/src/domains/functions"
      CostCenter   = "TS000 - Tecnologia e Servizi"
    }

    # Switch limit date for email opt out mode. This value should be used by functions that need to discriminate
    # how to check isInboxEnabled property on IO profiles, since we have to disable email notifications for default
    # for all profiles that have been updated before this date. This date should coincide with new IO App's release date
    # 1625781600 value refers to 2021-07-09T00:00:00 GMT+02:00
    opt_out_email_switch_date = 1625781600

    # Feature flag used to enable email opt-in with logic exposed by the previous variable usage
    ff_opt_in_email_enabled = "true"

    apim_hostname_api_internal = "api-internal.io.italia.it"

    # MESSAGES
    message_content_container_name = "message-content"

    service_api_url = "https://api-app.internal.io.pagopa.it/"

    cidr_subnet_services_old            = "10.20.34.0/26"
    cidr_subnet_services                = "10.20.41.0/26"
    function_services_autoscale_minimum = 3
    function_services_autoscale_maximum = 30
    function_services_autoscale_default = 10

    vnet_common_name_itn           = "${local.project_itn}-common-vnet-01"
    common_resource_group_name_itn = "${local.project_itn}-common-rg-01"

    apim_itn_name = "${local.project_itn}-apim-01"
  }

  continua = {
    cidr_subnet_continua = "10.20.35.0/26"
    vnet_common_name_itn = "${local.project_itn}-common-vnet-01"
  }

  function_admin = {
    cidr_subnet_admin = "10.20.34.64/26"

    vnet_common_name_itn           = "${local.project_itn}-common-vnet-01"
    common_resource_group_name_itn = "${local.project_itn}-common-rg-01"

    apim_itn_name = "${local.project_itn}-apim-01"
  }

  function_elt = {

    location                        = "westeurope"
    secondary_location_display_name = "North Europe"

    vnet_common_name_itn           = "${local.project_itn}-common-vnet-01"
    common_resource_group_name_itn = "${local.project_itn}-common-rg-01"

    location_itn        = "italynorth"
    resource_group_name = "io-p-itn-elt-rg-01"
    elt_snet_cidr       = "10.20.40.0/26"

    tags = {
      CostCenter     = "TS000 - Tecnologia e Servizi"
      CreatedBy      = "Terraform"
      Environment    = "Prod"
      BusinessUnit   = "App IO"
      Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/elt/prod"
      ManagementTeam = "IO Platform"
    }
  }
  function_assets_cdn = {
    assets_cdn_snet_cidr = "10.20.35.64/26"

    vnet_common_name_itn           = "${local.project_itn}-common-vnet-01"
    common_resource_group_name_itn = "${local.project_itn}-common-rg-01"
  }
}
