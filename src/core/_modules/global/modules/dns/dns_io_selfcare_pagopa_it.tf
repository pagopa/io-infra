resource "azurerm_dns_zone" "io_selfcare_pagopa_it" {
  count               = (var.dns_zones.io_selfcare == null || var.external_domain == null) ? 0 : 1
  name                = join(".", [var.dns_zones.io_selfcare, var.external_domain])
  resource_group_name = var.resource_groups.external

  tags = var.tags
}

resource "azurerm_dns_caa_record" "io_selfcare_pagopa_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.io_selfcare_pagopa_it[0].name
  resource_group_name = var.resource_groups.external
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
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  records             = [var.app_gateway_public_ip]

  tags = var.tags
}
