resource "azurerm_resource_group" "data_rg" {
  name     = format("%s-data-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "backend_rg" {
  name     = format("%s-backend-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_resource_group" "sec_rg" {
  name     = format("%s-sec-rg", local.project)
  location = var.location

  tags = var.tags
}
