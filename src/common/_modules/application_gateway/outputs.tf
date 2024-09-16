output "public_ip" {
  value = {
    address             = azurerm_public_ip.appgateway_public_ip.ip_address
    id                  = azurerm_public_ip.appgateway_public_ip.id
    name                = azurerm_public_ip.appgateway_public_ip.name
    resource_group_name = azurerm_public_ip.appgateway_public_ip.resource_group_name
  }
}

output "snet" {
  value = {
    id               = azurerm_subnet.agw_snet.id
    name             = azurerm_subnet.agw_snet.name
    address_prefixes = azurerm_subnet.agw_snet.address_prefixes
  }
}