output "snet" {
  value = {
    id               = azurerm_subnet.io_proxy.id
    name             = azurerm_subnet.io_proxy.name
    address_prefixes = azurerm_subnet.io_proxy.address_prefixes
  }
}

output "private_ips" {
  value = module.io_proxy.private_ip_addresses
}

output "id" {
  value = module.io_proxy.id
}