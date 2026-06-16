resource "azurerm_dns_zone" "wallet_io_pagopa_it" {
  name                = "wallet.io.pagopa.it"
  resource_group_name = var.resource_groups.external

  tags = var.tags
}
