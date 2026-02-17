locals {
  prefix    = "io"
  env_short = "p"
  project   = "${local.prefix}-${local.env_short}"

  dns_zone_io     = "io"
  external_domain = "pagopa.it"

  apim_hostname_api_app_internal = format("api-app.internal.%s.%s", local.dns_zone_io, local.external_domain)

  # WEU
  apim_v2_name             = "${local.project}-apim-v2-api"
  apim_resource_group_name = "${local.project}-rg-internal"
  # ITN
  apim_itn_name                = "${local.project}-itn-apim-01"
  apim_itn_resource_group_name = "${local.project}-itn-common-rg-01"
}
