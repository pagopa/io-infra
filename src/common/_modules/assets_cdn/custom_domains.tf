resource "azurerm_dns_cname_record" "assets_cdn_io_pagopa_it" {
  name                = "assets.cdn"
  zone_name           = var.public_dns_zones.io.name
  resource_group_name = var.resource_group_external
  ttl                 = var.dns_default_ttl_sec
  record              = "redirect.assets.cdn.io.pagopa.it" # Switched to temporary AGW

  tags = var.tags
}
