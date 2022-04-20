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

# module "vnet_peering_common_weu_beta" {
#   source = "git::https://github.com/pagopa/azurerm.git//virtual_network_peering?ref=v2.12.2"

#   location = var.location

#   source_resource_group_name       = data.azurerm_resource_group.vnet_common_rg.name
#   source_virtual_network_name      = data.azurerm_virtual_network.vnet_common.name
#   source_remote_virtual_network_id = data.azurerm_virtual_network.vnet_common.id
#   source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet to vnet_integration
#   target_resource_group_name       = azurerm_resource_group.weu_beta_rg.name
#   target_virtual_network_name      = module.vnet_weu_beta.name
#   target_remote_virtual_network_id = module.vnet_weu_beta.id
#   target_use_remote_gateways       = true
# }

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
