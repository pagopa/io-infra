resource "azurerm_cdn_frontdoor_custom_domain" "assets_cdn_io_pagopa_it" {
  name                     = "assets-cdn-io-pagopa-it"
  cdn_frontdoor_profile_id = module.azure_cdn.endpoint_id
  dns_zone_id              = var.public_dns_zones.io.id
  host_name                = "assets.cdn.io.pagopa.it"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "assets_cdn_io_italia_it" {
  name                     = "assets-cdn-io-italia-it"
  cdn_frontdoor_profile_id = module.azure_cdn.endpoint_id
  dns_zone_id              = var.public_dns_zones.io_italia_it.id
  host_name                = "assets.cdn.io.italia.it"

  tls {
    certificate_type = "ManagedCertificate"
  }
}