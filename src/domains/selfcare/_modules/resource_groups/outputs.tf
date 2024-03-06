output "resource_group_selfcare_be" {
  value = {
    id       = azurerm_resource_group.resource_group_selfcare_be.id
    name     = azurerm_resource_group.resource_group_selfcare_be.name
    location = azurerm_resource_group.resource_group_selfcare_be.location
  }
}

output "resource_group_selfcare_fe" {
  value = {
    id       = azurerm_resource_group.resource_group_selfcare_fe.id
    name     = azurerm_resource_group.resource_group_selfcare_fe.name
    location = azurerm_resource_group.resource_group_selfcare_fe.location
  }
}

output "resource_group_selfcare_imad" {
  value = {
    id       = azurerm_resource_group.resource_group_selfcare_imad.id
    name     = azurerm_resource_group.resource_group_selfcare_imad.name
    location = azurerm_resource_group.resource_group_selfcare_imad.location
  }
}

