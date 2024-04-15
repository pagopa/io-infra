resource "azurerm_resource_group" "rg_vnet" {
  name     = format("%s-vnet-rg", local.project)
  location = var.location

  tags = var.tags
}

module "vnet_common" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network?ref=v7.61.0"
  name                 = "${local.project}-vnet-common"
  location             = azurerm_resource_group.rg_common.location
  resource_group_name  = azurerm_resource_group.rg_common.name
  address_space        = var.cidr_common_vnet
  ddos_protection_plan = var.ddos_protection_plan

  tags = var.tags
}

resource "azurerm_resource_group" "weu_beta_vnet_rg" {
  name     = "${local.project}-weu-beta-vnet-rg"
  location = var.location

  tags = var.tags
}

module "vnet_weu_beta" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network?ref=v7.61.0"
  name                 = "${local.project}-weu-beta-vnet"
  location             = azurerm_resource_group.weu_beta_vnet_rg.location
  resource_group_name  = azurerm_resource_group.weu_beta_vnet_rg.name
  address_space        = var.cidr_weu_beta_vnet
  ddos_protection_plan = var.ddos_protection_plan

  tags = var.tags
}

module "vnet_peering_common_weu_beta" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering?ref=v7.61.0"

  source_resource_group_name       = azurerm_resource_group.rg_common.name
  source_virtual_network_name      = module.vnet_common.name
  source_remote_virtual_network_id = module.vnet_common.id
  source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet to vnet_integration
  target_resource_group_name       = azurerm_resource_group.weu_beta_vnet_rg.name
  target_virtual_network_name      = module.vnet_weu_beta.name
  target_remote_virtual_network_id = module.vnet_weu_beta.id
  target_use_remote_gateways       = true # needed by vpn gateway for enabling routing from vnet to vnet_integration
}

resource "azurerm_resource_group" "weu_prod01_vnet_rg" {
  name     = "${local.project}-weu-prod01-vnet-rg"
  location = var.location

  tags = var.tags
}

module "vnet_weu_prod01" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network?ref=v7.61.0"
  name                 = "${local.project}-weu-prod01-vnet"
  location             = azurerm_resource_group.weu_prod01_vnet_rg.location
  resource_group_name  = azurerm_resource_group.weu_prod01_vnet_rg.name
  address_space        = var.cidr_weu_prod01_vnet
  ddos_protection_plan = var.ddos_protection_plan

  tags = var.tags
}

module "vnet_peering_common_weu_prod01" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network_peering?ref=v7.61.0"

  source_resource_group_name       = azurerm_resource_group.rg_common.name
  source_virtual_network_name      = module.vnet_common.name
  source_remote_virtual_network_id = module.vnet_common.id
  source_allow_gateway_transit     = true # needed by vpn gateway for enabling routing from vnet to vnet_integration
  target_resource_group_name       = azurerm_resource_group.weu_prod01_vnet_rg.name
  target_virtual_network_name      = module.vnet_weu_prod01.name
  target_remote_virtual_network_id = module.vnet_weu_prod01.id
  target_use_remote_gateways       = true # needed by vpn gateway for enabling routing from vnet to vnet_integration
}

module "private_endpoints_subnet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.61.0"
  name                 = "pendpoints"
  address_prefixes     = var.cidr_subnet_pendpoints
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = module.vnet_common.name

  private_endpoint_network_policies_enabled = false
}

# TODO OLD APIM subnet to REMOVE
module "apim_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.61.0"
  name                 = "apimapi"
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = module.vnet_common.name
  address_prefixes     = var.cidr_subnet_apim

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
  ]
}
