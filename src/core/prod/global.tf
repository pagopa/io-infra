module "dns" {
  source = "../_modules/dns"

  resource_group_name = azurerm_resource_group.common_weu.name

  vnets = {
    itn_keyvault_vnet_common = {
      id   = module.networking_itn.vnet_common.id
      name = module.networking_itn.vnet_common.name
    }
    weu_keyvault_vnet_common = {
      id   = module.networking_weu.vnet_common.id
      name = module.networking_weu.vnet_common.name
    }
  }

  tags = local.tags
}
