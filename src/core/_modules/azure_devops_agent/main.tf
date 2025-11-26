resource "azurerm_resource_group" "azdoa_rg" {
  name     = try(local.nonstandard[var.location_short].rg, "${var.project}-azdoa-rg-01")
  location = var.location

  tags = var.tags
}

module "azdoa_snet" {
  source = "github.com/pagopa/terraform-azurerm-v4//subnet?ref=v7.52.0"

  name                                      = try(local.nonstandard[var.location_short].snet, "${var.project}-azdoa-snet-01")
  address_prefixes                          = var.cidr_subnet
  resource_group_name                       = var.resource_groups.common
  virtual_network_name                      = var.vnet_common.name
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
  ]
}

module "azdoa_li_infra" {
  source              = "github.com/pagopa/terraform-azurerm-v4//azure_devops_agent?ref=v7.52.0"
  name                = try(local.nonstandard[var.location_short].li_infra, "${var.project}-azdoa-infra-vmss-01")
  resource_group_name = azurerm_resource_group.azdoa_rg.name
  subnet_id           = module.azdoa_snet.id
  subscription_id     = var.datasources.azurerm_client_config.subscription_id
  location            = var.location
  source_image_name   = local.image_name
  vm_sku              = "Standard_B2als_v2"

  tags = var.tags
}

module "azdoa_loadtest_li" {
  source              = "github.com/pagopa/terraform-azurerm-v4//azure_devops_agent?ref=v7.52.0"
  name                = try(local.nonstandard[var.location_short].li_loadtest, "${var.project}-azdoa-loadtest-vmss-01")
  resource_group_name = azurerm_resource_group.azdoa_rg.name
  subnet_id           = module.azdoa_snet.id
  subscription_id     = var.datasources.azurerm_client_config.subscription_id
  location            = var.location
  source_image_name   = local.image_name
  vm_sku              = "Standard_D8ds_v5"

  tags = var.tags
}
