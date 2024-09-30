locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  dns_zone_io     = "io"
  external_domain = "pagopa.it"

  apim_hostname_api_app_internal = format("api-app.internal.%s.%s", local.dns_zone_io, local.external_domain)
}
