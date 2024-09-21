output "snet" {
  value = {
    id               = azurerm_subnet.apim.id
    name             = azurerm_subnet.apim.name
    address_prefixes = azurerm_subnet.apim.address_prefixes
  }
}

output "public_ip" {
  value = {
    address             = azurerm_public_ip.apim.ip_address
    id                  = azurerm_public_ip.apim.id
    name                = azurerm_public_ip.apim.name
    resource_group_name = azurerm_public_ip.apim.resource_group_name
  }
}