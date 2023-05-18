resource "azurerm_dns_zone" "firma_io_pagopa_it" {
  count = var.env_short == "p" ? 1 : 0

  name                = var.dns_zone_name
  resource_group_name = azurerm_resource_group.integration_rg.name

  tags = var.tags
}

resource "azurerm_dns_cname_record" "ses_validation_firma_io_pagopa_it" {
  for_each = { for v in var.dns_ses_validation : v.name => v }

  name                = each.value.name
  record              = each.value.record
  zone_name           = azurerm_dns_zone.firma_io_pagopa_it[0].name
  resource_group_name = azurerm_resource_group.integration_rg.name
  ttl                 = var.dns_default_ttl_sec
}
