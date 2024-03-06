locals {
  dns_zone_io_selfcare = "io.selfcare"
  external_domain      = "pagopa.it"

  dns_zone_name = join(".", [local.dns_zone_io_selfcare, local.external_domain])
}
