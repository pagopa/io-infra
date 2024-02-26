output "resource_group" {
  value = {
    id       = azurerm_resource_group.cgn_be_rg.id
    name     = azurerm_resource_group.cgn_be_rg.name
    location = azurerm_resource_group.cgn_be_rg.location
  }
}
