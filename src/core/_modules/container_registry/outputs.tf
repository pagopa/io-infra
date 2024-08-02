output "acr" {
  value = {
    id           = azurerm_container_registry.this.id
    login_server = azurerm_container_registry.this.login_server
  }
}
