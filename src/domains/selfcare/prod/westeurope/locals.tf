locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location = "westeurope"

  external_domain                = "pagopa.it"
  apim_hostname_api_app_internal = format("api-app.internal.io.%s", local.external_domain)
  devportal_frontend_hostname    = "developer.io.italia.it"

  tags = {
    CostCenter     = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy      = "Terraform"
    Environment    = "Prod"
    Owner          = "IO"
    ManagementTeam = "IO Enti & Servizi"
    Source         = "https://github.com/pagopa/io-infra/blob/main/src/domains/selfcare/prod/westeurope"
  }

  # ITN
  apim_itn_name                = "${local.project}-itn-apim-01"
  apim_itn_resource_group_name = "${local.project}-itn-common-rg-01"
}
