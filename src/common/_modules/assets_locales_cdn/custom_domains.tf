resource "azurerm_cdn_endpoint_custom_domain" "assets_cdn" {
  depends_on = [
    azurerm_dns_cname_record.assets_cdn_io_pagopa_it,
  ]

  name            = replace("${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${var.public_dns_zones.io.name}", ".", "-")
  cdn_endpoint_id = azurerm_cdn_endpoint.assets_cdn_endpoint.id
  host_name       = "${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${var.public_dns_zones.io.name}"
  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}

resource "azurerm_cdn_endpoint_custom_domain" "assets_cdn_io_italia_it" {
  depends_on = [
    azurerm_dns_cname_record.assets_cdn_io_italia_it,
  ]

  name            = replace("${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${var.public_dns_zones.io_italia_it.name}", ".", "-")
  cdn_endpoint_id = azurerm_cdn_endpoint.assets_cdn_endpoint.id
  host_name       = "${azurerm_dns_cname_record.assets_cdn_io_pagopa_it.name}.${var.public_dns_zones.io_italia_it.name}"
  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
    tls_version      = "TLS12"
  }
}
