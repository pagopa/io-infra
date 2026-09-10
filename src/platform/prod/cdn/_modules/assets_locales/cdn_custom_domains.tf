resource "azurerm_cdn_frontdoor_custom_domain" "assets_cdn_io_italia_it" {
  name                     = "assets-cdn-io-italia-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.assets_locales_frontdoor_profile.id
  dns_zone_id              = var.public_dns_zones.io_italia_it.id
  host_name = "assets.cdn.io.italia.it"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "assets_cdn_io_pagopa_it" {
  name                     = "assets-cdn-io-pagopa-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.assets_locales_frontdoor_profile.id
  dns_zone_id              = var.public_dns_zones.io.id
  host_name = "assets.cdn.io.pagopa.it"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "assets_io_pagopa_it" {
  name                     = "assets-io-pagopa-it"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.assets_locales_frontdoor_profile.id
  dns_zone_id              = var.public_dns_zones.io.id
  host_name = "assets.io.pagopa.it"

  tls {
    certificate_type = "ManagedCertificate"
  }
}

