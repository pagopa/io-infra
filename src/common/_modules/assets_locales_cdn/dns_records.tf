resource "azurerm_dns_cname_record" "assets_io_pagopa_it" {
  name                = "assets"
  zone_name           = var.public_dns_zones.io.name
  resource_group_name = var.resource_group_external
  ttl                 = var.dns_default_ttl_sec
  record              = azurerm_cdn_frontdoor_endpoint.cdn_endpoint.host_name

  tags = var.tags
}
