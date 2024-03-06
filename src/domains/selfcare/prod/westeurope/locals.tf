locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  location = "westeurope"

  dns_zone_io_selfcare           = "io.selfcare"
  external_domain                = "pagopa.it"
  dns_zone_name                  = join(".", [local.dns_zone_io_selfcare, local.external_domain])
  backend_hostname               = "api.${local.dns_zone_name}"
  frontend_hostname              = local.dns_zone_name
  apim_hostname_api_app_internal = format("api-app.internal.%s.%s", local.dns_zone_io_selfcare, local.external_domain)
  apim_hostname_api_internal     = "api-internal.io.italia.it"
  selfcare_external_hostname     = "selfcare.pagopa.it"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Prod"
    Owner       = "IO"
    Source      = "https://github.com/pagopa/io-infra" #"https://github.com/pagopa/io-infra/blob/main/src/domains/selfcare/prod/west-europe"
  }
}
