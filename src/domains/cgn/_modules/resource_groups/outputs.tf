output "resource_group_cgn_be" {
  value = {
    id       = azurerm_resource_group.resource_group_cgn_be.id
    name     = azurerm_resource_group.resource_group_cgn_be.name
    location = azurerm_resource_group.resource_group_cgn_be.location
  }
}

output "resource_group_cgn" {
  value = {
    id       = azurerm_resource_group.resource_group_cgn.id
    name     = azurerm_resource_group.resource_group_cgn.name
    location = azurerm_resource_group.resource_group_cgn.location
  }
}
