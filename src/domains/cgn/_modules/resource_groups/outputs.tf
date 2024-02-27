output "resource_group_be_cgn" {
  value = {
    id       = azurerm_resource_group.rg_be_cgn.id
    name     = azurerm_resource_group.rg_be_cgn.name
    location = azurerm_resource_group.rg_be_cgn.location
  }
}

output "resource_group_cgn" {
  value = {
    id       = azurerm_resource_group.rg_cgn.id
    name     = azurerm_resource_group.rg_cgn.name
    location = azurerm_resource_group.rg_cgn.location
  }
}
