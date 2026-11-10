moved {
  from = module.vpn_weu.module.dns_forwarder.azurerm_container_group.this
  to   = module.vpn_weu.azurerm_container_group.dns_forwarder
}

moved {
  from = module.vpn_weu.module.dns_forwarder_snet.azurerm_subnet.this
  to   = module.vpn_weu.azurerm_subnet.dns_forwarder
}

moved {
  from = module.vpn_weu.module.vpn.azurerm_public_ip.gw[0]
  to   = module.vpn_weu.azurerm_public_ip.vpn_gw
}

moved {
  from = module.vpn_weu.module.vpn.azurerm_virtual_network_gateway.gw
  to   = module.vpn_weu.azurerm_virtual_network_gateway.vpn_gw
}

moved {
  from = module.vpn_weu.module.vpn.random_string.dns
  to   = module.vpn_weu.random_string.dns
}