output "public_ip" {
  value = {
    address             = azurerm_public_ip.agw.ip_address
    id                  = azurerm_public_ip.agw.id
    name                = azurerm_public_ip.agw.name
    resource_group_name = azurerm_public_ip.agw.resource_group_name
  }
}

output "snet" {
  value = {
    id               = azurerm_subnet.agw.id
    name             = azurerm_subnet.agw.name
    address_prefixes = azurerm_subnet.agw.address_prefixes
  }
}
