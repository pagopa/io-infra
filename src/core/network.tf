resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_resource_group" "vnet_common_rg" {
  name = var.common_rg
}

# vnet
data "azurerm_virtual_network" "vnet_common" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnet_common_rg.name
}

# vnet
resource "azurerm_resource_group" "weu_beta_rg" {
  name     = "${local.project}-weu-beta-rg"
  location = var.location

  tags = var.tags
}

module "vnet_weu_beta" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v2.12.2"
  name                = "${local.project}-weu-beta-vnet"
  location            = azurerm_resource_group.weu_beta_rg.location
  resource_group_name = azurerm_resource_group.weu_beta_rg.name
  address_space       = var.cidr_weu_beta_vnet

  tags = var.tags
}

resource "azurerm_resource_group" "weu_prod01_rg" {
  name     = "${local.project}-weu-prod01-rg"
  location = var.location

  tags = var.tags
}

module "vnet_weu_prod01" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v2.12.2"
  name                = "${local.project}-weu-prod01-vnet"
  location            = azurerm_resource_group.weu_prod01_rg.location
  resource_group_name = azurerm_resource_group.weu_prod01_rg.name
  address_space       = var.cidr_weu_prod01_vnet

  tags = var.tags
}

resource "azurerm_resource_group" "weu_prod02_rg" {
  name     = "${local.project}-weu-prod02-rg"
  location = var.location

  tags = var.tags
}

module "vnet_weu_prod02" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v2.12.2"
  name                = "${local.project}-weu-prod02-vnet"
  location            = azurerm_resource_group.weu_prod02_rg.location
  resource_group_name = azurerm_resource_group.weu_prod02_rg.name
  address_space       = var.cidr_weu_prod02_vnet

  tags = var.tags
}
