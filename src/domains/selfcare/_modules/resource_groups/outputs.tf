output "resource_group_selfcare_be" {
  value = {
    id       = azurerm_resource_group.resource_group_selfcare_be.id
    name     = azurerm_resource_group.resource_group_selfcare_be.name
    location = azurerm_resource_group.resource_group_selfcare_be.location
  }
}
