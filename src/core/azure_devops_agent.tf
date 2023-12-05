resource "azurerm_resource_group" "azdo_rg" {
  count    = var.enable_azdoa ? 1 : 0
  name     = format("%s-azdoa-rg", local.project)
  location = var.location

  tags = var.tags
}

module "azdoa_snet" {
  count  = var.enable_azdoa ? 1 : 0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.28.0"

  name                                      = "azure-devops"
  address_prefixes                          = var.cidr_subnet_azdoa
  resource_group_name                       = azurerm_resource_group.rg_common.name
  virtual_network_name                      = module.vnet_common.name
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
  ]
}

module "azdoa_li_infra" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent?ref=v7.28.0"
  count               = var.enable_azdoa ? 1 : 0
  name                = "${local.project}-azdoa-vmss-li-infra"
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = module.azdoa_snet[0].id
  subscription_name   = data.azurerm_subscription.current.display_name
  subscription_id     = data.azurerm_subscription.current.subscription_id
  location            = var.location
  source_image_name   = var.azdoa_image_name
  vm_sku              = "Standard_B2als_v2"

  tags = var.tags
}

module "azdoa_loadtest_li" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent?ref=v7.28.0"
  count               = var.enable_azdoa ? 1 : 0
  name                = format("%s-azdoa-vmss-loadtest-li", local.project)
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = module.azdoa_snet[0].id
  subscription_name   = data.azurerm_subscription.current.display_name
  subscription_id     = data.azurerm_subscription.current.subscription_id
  location            = var.location
  source_image_name   = var.azdoa_image_name
  vm_sku              = "Standard_D8ds_v5"

  tags = var.tags
}
