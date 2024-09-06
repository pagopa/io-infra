output "public_ip" {
  value = {
    address        = azurerm_public_ip.appgateway_public_ip.ip_address
    id             = azurerm_public_ip.appgateway_public_ip.id
    resource_group = azurerm_public_ip.appgateway_public_ip.resource_group_name
  }
}