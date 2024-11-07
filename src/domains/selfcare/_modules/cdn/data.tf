data "azurerm_dns_zone" "io_selfcare_pagopa_it" {
  name                = var.dns_zone_name
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

data "azurerm_virtual_network" "vnet_itn" {
  name                = "${var.project}-itn-common-vnet-01"
  resource_group_name = "${var.project}-itn-common-rg-01"
}

data "azurerm_subnet" "subnet_pep_itn" {
  name                 = "io-p-itn-pep-snet-01 "
  resource_group_name  = data.azurerm_virtual_network.vnet_itn.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.vnet_itn.name
}