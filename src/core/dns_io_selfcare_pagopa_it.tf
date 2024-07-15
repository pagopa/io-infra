resource "azurerm_dns_zone" "io_selfcare_pagopa_it" {
  count               = (var.dns_zone_io_selfcare == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zone_io_selfcare, var.external_domain])
  resource_group_name = azurerm_resource_group.rg_external.name

  tags = var.tags
}

resource "azurerm_dns_caa_record" "io_selfcare_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.io_selfcare_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec

  record {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }

  record {
    flags = 0
    tag   = "iodef"
    value = "mailto:security+caa@pagopa.it"
  }

  tags = var.tags
}

# application gateway records
# api.io.selfcare.pagopa.it
resource "azurerm_dns_a_record" "api_io_selfcare_pagopa_it" {
  name                = "api"
  zone_name           = azurerm_dns_zone.io_selfcare_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.rg_external.name
  ttl                 = var.dns_default_ttl_sec
  records             = [azurerm_public_ip.appgateway_public_ip.ip_address]

  tags = var.tags
}