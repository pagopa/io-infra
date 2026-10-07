output "snet" {
  value = {
    id               = azurerm_subnet.platform_api_gateway.id
    name             = azurerm_subnet.platform_api_gateway.name
    address_prefixes = azurerm_subnet.platform_api_gateway.address_prefixes
  }
}

output "private_ips" {
  value = module.platform_api_gateway.private_ip_addresses
}

output "id" {
  value = module.platform_api_gateway.id
}