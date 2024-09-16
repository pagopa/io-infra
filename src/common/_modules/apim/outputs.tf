output "snet" {
  value = {
    id               = azurerm_subnet.apim.id
    name             = azurerm_subnet.apim.name
    address_prefixes = azurerm_subnet.apim.address_prefixes
  }
}