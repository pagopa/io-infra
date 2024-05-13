data "azurerm_virtual_network" "common" {
  name                = "${local.project}-vnet-common"
  resource_group_name = "${local.project}-rg-common"
}

data "azurerm_subnet" "pep" {
  name                 = "pendpoints"
  virtual_network_name = data.azurerm_virtual_network.common.name
  resource_group_name  = data.azurerm_virtual_network.common.resource_group_name
}

data "azurerm_subnet" "fn3admin" {
  name                 = "fn3admin"
  virtual_network_name = data.azurerm_virtual_network.common.name
  resource_group_name  = data.azurerm_virtual_network.common.resource_group_name
}

data "azurerm_subnet" "fn3app1" {
  name                 = "fn3app1"
  virtual_network_name = data.azurerm_virtual_network.common.name
  resource_group_name  = data.azurerm_virtual_network.common.resource_group_name
}

data "azurerm_subnet" "fn3app2" {
  name                 = "fn3app2"
  virtual_network_name = data.azurerm_virtual_network.common.name
  resource_group_name  = data.azurerm_virtual_network.common.resource_group_name
}

data "azurerm_subnet" "fn3appasync" {
  name                 = "fn3appasync"
  virtual_network_name = data.azurerm_virtual_network.common.name
  resource_group_name  = data.azurerm_virtual_network.common.resource_group_name
}

data "azurerm_subnet" "fn3assets" {
  name                 = "fn3assets"
  virtual_network_name = data.azurerm_virtual_network.common.name
  resource_group_name  = data.azurerm_virtual_network.common.resource_group_name
}

data "azurerm_subnet" "fn3public" {
  name                 = "fn3public"
  virtual_network_name = data.azurerm_virtual_network.common.name
  resource_group_name  = data.azurerm_virtual_network.common.resource_group_name
}

data "azurerm_subnet" "fn3services" {
  name                 = "fn3services"
  virtual_network_name = data.azurerm_virtual_network.common.name
  resource_group_name  = data.azurerm_virtual_network.common.resource_group_name
}

data "azurerm_subnet" "fn3slackbot" {
  name                 = "fn3slackbot"
  virtual_network_name = data.azurerm_virtual_network.common.name
  resource_group_name  = data.azurerm_virtual_network.common.resource_group_name
}

data "azurerm_private_dns_zone" "documents" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = "${local.project}-rg-common"
}
