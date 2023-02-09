resource "azurerm_resource_group" "azdo_rg" {
  count    = var.enable_azdoa ? 1 : 0
  name     = format("%s-azdoa-rg", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_subnet" "azdoa_snet" {
  count                = var.enable_azdoa ? 1 : 0
  name                 = "azure-devops"
  virtual_network_name = data.azurerm_virtual_network.vnet_common.name
  resource_group_name  = data.azurerm_resource_group.vnet_common_rg.name
}

module "azdoa_li" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent?ref=v4.1.15"
  count               = var.enable_azdoa ? 1 : 0
  name                = format("%s-azdoa-vmss-li", local.project)
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = data.azurerm_subnet.azdoa_snet[0].id
  subscription        = data.azurerm_subscription.current.display_name

  tags = var.tags
}

module "azdoa_loadtest_li" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent?ref=v4.1.15"
  count               = var.enable_azdoa ? 1 : 0
  name                = format("%s-azdoa-vmss-loadtest-li", local.project)
  resource_group_name = azurerm_resource_group.azdo_rg[0].name
  subnet_id           = data.azurerm_subnet.azdoa_snet[0].id
  subscription        = data.azurerm_subscription.current.display_name
  vm_sku              = "Standard_D8ds_v5"

  tags = var.tags
}
