data "azurerm_dns_zone" "io_selfcare_pagopa_it" {
  name                = local.dns_zone_name
  resource_group_name = "${var.project}-rg-external"
}

data "azurerm_key_vault" "key_vault_io" {
  name                = "${var.project}-kv"
  resource_group_name = "${var.project}-sec-rg"
}

data "azurerm_log_analytics_workspace" "law_common" {
  name                = "${var.project}-law-common"
  resource_group_name = "${var.project}-rg-common"
}

data "azurerm_subscription" "current" {}
