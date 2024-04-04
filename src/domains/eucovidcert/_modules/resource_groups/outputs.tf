output "resource_group_eucovidcert" {
  value = {
    id       = azurerm_resource_group.eucovidcert.id
    name     = azurerm_resource_group.eucovidcert.name
    location = azurerm_resource_group.eucovidcert.location
  }
}
