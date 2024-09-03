output "public_ip" {
    value = azurerm_public_ip.appgateway_public_ip.ip_address
}