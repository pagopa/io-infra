resource "azurerm_resource_group" "sec_rg" {
  name     = format("%s-sec-rg", local.project)
  location = var.location

  tags = var.tags
}

#tfsec:ignore:azure-keyvault-specify-network-acl:exp:2022-05-01 # already ignored, maybe a bug in tfsec
module "key_vault" {
  source              = "git::https://github.com/pagopa/azurerm.git//key_vault?ref=v2.0.2"
  name                = format("%s-kv", local.project)
  location            = azurerm_resource_group.sec_rg.location
  resource_group_name = azurerm_resource_group.sec_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  lock_enable         = var.lock_enable

  tags = var.tags
}

data "azurerm_key_vault" "common" {
  name                = format("%s-kv-common", local.project)
  resource_group_name = format("%s-rg-common", local.project)
}
