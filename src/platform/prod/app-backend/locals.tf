locals {
  prefix             = "io"
  env_short          = "p"
  location           = { westeurope = "westeurope", italynorth = "italynorth" }
  location_short     = { westeurope = "weu", italynorth = "itn" }
  project_itn        = "${local.prefix}-${local.env_short}-${local.location_short.italynorth}"
  project_weu        = "${local.prefix}-${local.env_short}-${local.location_short.westeurope}"
  project_weu_legacy = "${local.prefix}-${local.env_short}"

  app_backends = {
    1 = {
      cidr_subnet = ["10.0.152.0/24"]
    },
    2 = {
      cidr_subnet = ["10.0.153.0/24"]
    }
  }

  backend_hostnames = {
    app                  = [data.azurerm_linux_function_app.function_profile.default_hostname]
    com_citizen_func     = data.azurerm_linux_function_app.com_citizen_func.default_hostname
    services_app_backend = data.azurerm_linux_function_app.services_app_backend_function_app.default_hostname
    # services_app_backend = data.azurerm_container_app.services_app_backend_function_app.ingress[0].fqdn
    lollipop      = data.azurerm_linux_function_app.lollipop_function.default_hostname
    cgn           = "io-p-itn-cgn-card-func-02.azurewebsites.net"
    iosign        = data.azurerm_linux_function_app.io_sign_user.default_hostname
    iofims        = data.azurerm_linux_function_app.io_fims_user.default_hostname
    cgnonboarding = "io-p-itn-cgn-search-func-02.azurewebsites.net"
    cdc_support   = "io-p-itn-cdc-support-func-01.azurewebsites.net"
  }

  core                   = data.terraform_remote_state.core.outputs
  common                 = data.terraform_remote_state.common.outputs
  platform_core          = data.terraform_remote_state.platform_core.outputs
  platform_observability = data.terraform_remote_state.platform_observability.outputs

  tags = {
    CostCenter   = "TS000 - Tecnologia e Servizi"
    CreatedBy    = "Terraform"
    Environment  = "Prod"
    BusinessUnit = "App IO"
    Source       = "https://github.com/pagopa/io-infra/blob/main/src/common/prod" # TODO: change tags after import
    #Source         = "https://github.com/pagopa/io-infra/blob/main/src/platform/cdn/prod"
    ManagementTeam = "IO Platform"
  }
}