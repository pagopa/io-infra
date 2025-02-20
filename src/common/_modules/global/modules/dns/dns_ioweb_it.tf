resource "azurerm_dns_zone" "ioweb_it" {
  name                = "ioapp.it"
  resource_group_name = var.resource_groups.external

  tags = var.tags
}

resource "azurerm_dns_caa_record" "ioweb_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.ioweb_it.name
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

# DMARC record for ioapp.it
resource "azurerm_dns_txt_record" "dmarc_ioweb_it" {
  name                = "_dmarc"
  zone_name           = azurerm_dns_zone.ioweb_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=DMARC1; p=reject; rua=mailto:dmarc@0f1qy7b5.uriports.com; aspf=s; adkim=s"
  }
  tags = var.tags
}

# set SPF to "empty" for ioapp.it
resource "azurerm_dns_txt_record" "spf_ioweb_it" {
  name                = "@"
  zone_name           = azurerm_dns_zone.ioweb_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record {
    value = "v=spf1 -all"
  }

  record {
    value = "google-site-verification=5hl_cVSx7flbf8w3CtMRXNHYlXtjtmzjNBuSX7SEyhg"
  }

  tags = var.tags
}

# CNAME for zendesk help center
resource "azurerm_dns_cname_record" "zendesk" {
  name                = "assistenza"
  zone_name           = azurerm_dns_zone.ioweb_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record              = "hc-io.zendesk.com"
}

resource "azurerm_dns_cname_record" "aws_cert_validation_ioweb" {
  name                = "_7ce011f45ecea256e0c064ca72caa4fc.www"
  zone_name           = azurerm_dns_zone.ioweb_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record              = "_3af6a29172223d1e69982ed93c9beffb.zfyfvmchrl.acm-validations.aws."
}

resource "azurerm_dns_cname_record" "ioweb_www" {
  name                = "www"
  zone_name           = azurerm_dns_zone.ioweb_it.name
  resource_group_name = var.resource_groups.external
  ttl                 = var.dns_default_ttl_sec
  record              = "d2m1nc4792c1zk.cloudfront.net"
}