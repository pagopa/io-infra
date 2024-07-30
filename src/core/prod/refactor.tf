import {
  to = module.vpn_weu.module.dns_forwarder.azurerm_container_group.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.ContainerInstance/containerGroups/io-p-dns-forwarder"
}

import {
  to = module.vpn_weu.module.dns_forwarder_snet.azurerm_subnet.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/io-p-dnsforwarder"
}

import {
  to = module.vpn_weu.module.vpn.azurerm_public_ip.gw[0]
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/publicIPAddresses/io-p-vpn-gw-pip"
}

import {
  to = module.vpn_weu.module.vpn.azurerm_virtual_network_gateway.gw
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworkGateways/io-p-vpn-gw"
}

import {
  to = module.vpn_weu.module.vpn_snet.azurerm_subnet.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/GatewaySubnet"
}