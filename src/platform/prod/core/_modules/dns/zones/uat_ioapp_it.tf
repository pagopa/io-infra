resource "azurerm_dns_zone" "uat_ioapp_it" {
  name                = "uat.ioapp.it"
  resource_group_name = var.resource_groups.external

  tags = var.tags
}

resource "azurerm_dns_caa_record" "uat_ioapp_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.uat_ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec

  record {
    flags = 0
    tag   = "issue"
    value = "letsencrypt.org"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "digicert.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "amazon.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "amazontrust.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "awstrust.com"
  }

  record {
    flags = 0
    tag   = "issue"
    value = "amazonaws.com"
  }

  record {
    flags = 0
    tag   = "iodef"
    value = "mailto:security+caa@pagopa.it"
  }

  tags = var.tags
}

resource "azurerm_dns_ns_record" "uat_ioapp_it_delegation" {
  name                = "uat"
  zone_name           = azurerm_dns_zone.ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec

  records = azurerm_dns_zone.uat_ioapp_it.name_servers
}

/*
# DMARC record for uat.ioapp.it
resource "azurerm_dns_txt_record" "dmarc_uat_ioapp_it" {
  name                = "_dmarc"
  zone_name           = azurerm_dns_zone.uat_ioapp_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=DMARC1; p=reject; rua=mailto:dmarc@0f1qy7b5.uriports.com; aspf=s; adkim=s"
  }
  tags = var.tags
}
*/