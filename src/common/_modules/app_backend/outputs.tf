output "snet" {
  value = {
    id               = azurerm_subnet.snet.id
    name             = azurerm_subnet.snet.name
    address_prefixes = azurerm_subnet.snet.address_prefixes
  }
}

output "default_hostname" {
  value = module.appservice_app_backend.default_site_hostname
}