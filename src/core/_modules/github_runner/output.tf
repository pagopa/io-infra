output "subnet" {
  value = {
    id   = azurerm_subnet.github_runner.id
    name = azurerm_subnet.github_runner.name
  }
}
