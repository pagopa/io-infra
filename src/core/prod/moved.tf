moved {
  from = module.vpn_weu.module.vpn_snet.azurerm_subnet.this
  to   = module.vpn_weu.azurerm_subnet.vpn
}

moved {
  from = module.vpn_weu.module.vpn_snet.azurerm_subnet.this
  to   = module.vpn_weu.azurerm_subnet.vpn
}

moved {
  from = module.networking_itn.module.pep_snet.azurerm_subnet.this
  to   = module.networking_itn.azurerm_subnet.pep
}

moved {
  from = module.networking_weu.module.pep_snet.azurerm_subnet.this
  to   = module.networking_weu.azurerm_subnet.pep
}

moved {
  from = module.networking_weu.module.vnet_common.azurerm_virtual_network.this
  to   = module.networking_weu.azurerm_virtual_network.common
}

moved {
  from = module.networking_itn.module.vnet_common.azurerm_virtual_network.this
  to   = module.networking_itn.azurerm_virtual_network.common
}

