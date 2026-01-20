resource "azurerm_cdn_frontdoor_custom_domain" "assets" {
  depends_on = [
    azurerm_dns_cname_record.assets_io_pagopa_it,
  ]

  name                     = replace("${azurerm_dns_cname_record.assets_io_pagopa_it.name}.${var.public_dns_zones.io.name}", ".", "-")
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.cdn_profile.id
  host_name                = "${azurerm_dns_cname_record.assets_io_pagopa_it.name}.${var.public_dns_zones.io.name}"
  tls {
    certificate_type = "ManagedCertificate"
  }
}
