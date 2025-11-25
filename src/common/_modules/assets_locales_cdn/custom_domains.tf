resource "azurerm_cdn_frontdoor_custom_domain" "assets_cdn" {
  depends_on = [
    azurerm_dns_cname_record.assets_cdn_io_pagopa_it,
  ]

  name                     = replace("${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${var.public_dns_zones.io.name}", ".", "-")
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_endpoint.assets_cdn_endpoint.id
  host_name                = "${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${var.public_dns_zones.io.name}"
  tls {
    certificate_type    = "Dedicated"
    minimum_tls_version = "TLS12"
  }
}

resource "azurerm_cdn_frontdoor_custom_domain" "assets_cdn_io_italia_it" {
  depends_on = [
    azurerm_dns_cname_record.assets_cdn_io_italia_it,
  ]

  name                     = replace("${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${var.public_dns_zones.io_italia_it.name}", ".", "-")
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_endpoint.assets_cdn_endpoint.id
  host_name                = "${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${var.public_dns_zones.io_italia_it.name}"
  tls {
    certificate_type    = "Dedicated"
    minimum_tls_version = "TLS12"
  }
}
