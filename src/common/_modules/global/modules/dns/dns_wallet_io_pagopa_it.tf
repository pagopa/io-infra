resource "azurerm_dns_zone" "wallet_io_pagopa_it" {
  name                = "wallet.io.pagopa.it"
  resource_group_name = var.resource_groups.external

  tags = var.tags
}

# TXT for Maven verification
resource "azurerm_dns_txt_record" "wallet_io_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.wallet_io_pagopa_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "qidvirtenu"
  }
  tags = var.tags
}